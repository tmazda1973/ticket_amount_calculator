require_relative '../../enums/ticket_amount/special_condition'

module TicketAmount
  #
  # CLIからの入力を制御するクラスです。
  #
  class InputReceiptOperator
    #
    # コンストラクタ
    # @param cli [Thor] コマンドラインインターフェース
    #
    def initialize(cli)
      @cli = cli
      @error_message = '入力値に誤りがあります。再入力してください。'
    end

    #
    # 処理を開始します。
    #
    def start
      @cli.adult_ticket_count = self._input_adult_ticket_count(@cli)
      @cli.child_ticket_count = self._input_child_ticket_count(@cli)
      @cli.senior_ticket_count = self._input_senior_ticket_count(@cli)
      @cli.special_conditions = self._input_special_conditions(@cli)
    end

    private
    #
    # チケット枚数（大人）の入力を受け付けます。
    # @param cli [Thor] コマンドラインインターフェース
    # @return [Integer] チケット枚数（大人）
    # @private
    #
    def _input_adult_ticket_count(cli)
      prompt = 'チケット枚数(大人) [数字]:'
      input = cli.ask(prompt)
      cli.send(:exit, 0) if input.downcase == 'q'
      until input =~ /^(0)|([1-9]\d*)$/
        cli.say(@error_message)
        input = cli.ask(prompt)
        cli.send(:exit, 0) if input.downcase == 'q'
      end
      input
    end

    #
    # チケット枚数（子供）の入力を受け付けます。
    # @param cli [Thor] コマンドラインインターフェース
    # @return [Integer] チケット枚数（子供）
    # @private
    #
    def _input_child_ticket_count(cli)
      prompt = 'チケット枚数(子供) [数字]:'
      input = cli.ask(prompt)
      cli.send(:exit, 0) if input.downcase == 'q'
      until input =~ /^(0)|([1-9]\d*)$/
        cli.say(@error_message)
        input = cli.ask(prompt)
        cli.send(:exit, 0) if input.downcase == 'q'
      end
      input
    end

    #
    # チケット枚数（シニア）の入力を受け付けます。
    # @param cli [Thor] コマンドラインインターフェース
    # @return [Integer] チケット枚数（シニア）
    # @private
    #
    def _input_senior_ticket_count(cli)
      prompt = 'チケット枚数(シニア) [数字]:'
      input = cli.ask(prompt)
      cli.send(:exit, 0) if input.downcase == 'q'
      until input =~ /^(0)|([1-9]\d*)$/
        cli.say(@error_message)
        input = cli.ask(prompt)
        cli.send(:exit, 0) if input.downcase == 'q'
      end
      input
    end

    #
    # 特別条件の入力を受け付けます。
    # @param cli [Thor] コマンドラインインターフェース
    # @return [Array] 特別条件
    # @private
    #
    def _input_special_conditions(cli)
      values = [] # 入力値
      prompt = <<-PROMPT
特別条件を入力してください。カンマ区切りで複数入力できます。(例: 1,2,3)
  1: 夕方料金
  2: 休日料金
  3: 月水割引

特別条件 [数字(複数入力可)]:
      PROMPT
      input = cli.ask(prompt)
      cli.send(:exit, 0) if input.downcase == 'q'
      until self._valid_special_conditions(input)
        cli.say(@error_message)
        input = cli.ask(prompt)
        cli.send(:exit, 0) if input.downcase == 'q'
      end
      values
    end

    #
    # 特別条件の入力値が正しいかを判定します。
    # @param input [String] 入力値
    # @return [Boolean] true 正しい、false 正しくない
    # @private
    #
    def _valid_special_conditions(input)
      allow_values = SpecialCondition.all # 許可する入力値
      input.split(',').each do |value|
        return false unless allow_values.include?(value.to_i)
      end
      true
    end
  end
end
