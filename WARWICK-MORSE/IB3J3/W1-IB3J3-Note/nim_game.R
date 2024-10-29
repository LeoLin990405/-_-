library(shiny)

# 计算当前局面的尼姆和
nim_sum <- function(piles) {
  Reduce(bitwXor, piles)
}

# 获取每个堆的二进制表示
piles_binary <- function(piles) {
  sapply(piles, function(pile) paste(intToBits(pile)[1:4], collapse = ""))
}

# 预测最佳移动，将局势变为平衡
suggest_winning_move <- function(piles) {
  suggestion <- ""
  for (i in seq_along(piles)) {
    for (remove_count in 1:piles[i]) {
      new_piles <- piles
      new_piles[i] <- new_piles[i] - remove_count
      if (nim_sum(new_piles) == 0) {
        suggestion <- paste(suggestion, "- 从第", i, "堆移走", remove_count, "个筹码可以将局势变为平衡。\n")
      }
    }
  }
  if (suggestion == "") {
    return("无合理策略。")
  } else {
    return(paste("策略提示：\n", suggestion))
  }
}

# UI部分，创建界面
ui <- fluidPage(
  titlePanel("尼姆游戏"),
  
  sidebarLayout(
    sidebarPanel(
      h3("玩家行动"),
      numericInput("pile_idx", "选择一堆 (从1开始):", value = 1, min = 1, max = 5, step = 1),
      numericInput("remove_count", "选择移走的筹码数量:", value = 1, min = 1, max = 10, step = 1),
      actionButton("move_button", "提交行动")
    ),
    
    mainPanel(
      h3("游戏状态"),
      verbatimTextOutput("piles_status"),       # 显示当前筹码堆
      verbatimTextOutput("piles_binary"),       # 显示筹码堆的二进制表示
      verbatimTextOutput("nim_sum_status"),     # 显示当前的尼姆和
      verbatimTextOutput("nim_sum_calculation"),# 显示尼姆和计算的过程
      verbatimTextOutput("strategy"),           # 显示策略提示
      verbatimTextOutput("player_turn"),        # 显示当前玩家
      verbatimTextOutput("predicted_move"),     # 预测对手行动
      verbatimTextOutput("winner")              # 显示赢家
    )
  )
)

# 服务器逻辑部分
server <- function(input, output, session) {
  
  # 初始化筹码堆
  piles <- reactiveVal(c(3, 4, 5, 8, 9))
  current_player <- reactiveVal(1)
  winner <- reactiveVal("")
  
  # 显示当前的筹码堆状况
  output$piles_status <- renderText({
    paste("当前的筹码堆状况: ", paste(piles(), collapse = " "))
  })
  
  # 显示每个堆的二进制表示
  output$piles_binary <- renderText({
    binary_piles <- piles_binary(piles())
    paste("筹码堆的二进制表示:\n", paste(binary_piles, collapse = "\n"))
  })
  
  # 显示当前的尼姆和
  output$nim_sum_status <- renderText({
    nim_sum_value <- nim_sum(piles())
    paste("当前的尼姆和: ", nim_sum_value)
  })
  
  # 显示尼姆和的计算过程
  output$nim_sum_calculation <- renderText({
    binary_piles <- piles_binary(piles())
    paste("尼姆和的计算过程 (按位异或):\n", paste(binary_piles, collapse = "\n"), 
          "\n最终结果: ", nim_sum(piles()))
  })
  
  # 显示当前的策略提示
  output$strategy <- renderText({
    if (nim_sum(piles()) == 0) {
      "当前是平衡局势，玩家可能处于不利地位。"
    } else {
      suggest_winning_move(piles())
    }
  })
  
  # 显示当前轮到的玩家
  output$player_turn <- renderText({
    paste("当前是玩家", current_player(), "的回合。")
  })
  
  # 预测对手的动作
  output$predicted_move <- renderText({
    if (nim_sum(piles()) != 0) {
      predict <- suggest_winning_move(piles())
      paste("预测：如果是对手的回合，可能采取的行动是：\n", predict)
    } else {
      "预测：对手可能随机行动。"
    }
  })
  
  # 更新筹码堆
  observeEvent(input$move_button, {
    pile_idx <- input$pile_idx
    remove_count <- input$remove_count
    
    # 检查是否符合规则
    if (pile_idx >= 1 && pile_idx <= length(piles()) && remove_count > 0 && remove_count <= piles()[pile_idx]) {
      new_piles <- piles()
      new_piles[pile_idx] <- new_piles[pile_idx] - remove_count
      piles(new_piles)
      
      # 检查是否游戏结束
      if (all(new_piles == 0)) {
        winner(paste("玩家", current_player(), "赢了！"))
      } else {
        # 切换玩家
        current_player(ifelse(current_player() == 1, 2, 1))
      }
    }
  })
  
  # 显示赢家
  output$winner <- renderText({
    winner()
  })
}

# 运行Shiny应用
shinyApp(ui = ui, server = server)
