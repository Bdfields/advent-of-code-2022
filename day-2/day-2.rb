class RockPaperScissors
    attr_accessor :file_name, :encrypted_moves, :scores

    PLAY_MAP = {
        'A' => 'R',
        'B' => 'P',
        'C' => 'S',
        'X' => 'R',
        'Y' => 'P',
        'Z' => 'S'
    }

    PLAY_VALUE_MAP = {
        'R' => 1,
        'P' => 2,
        'S' => 3
    }

    SCORE_MAP = {
        'RR' => 3,
        'RP' => 6,
        'RS' => 0,
        'PR' => 0,
        'PP' => 3,
        'PS' => 6,
        'SR' => 6,
        'SP' => 0,
        'SS' => 3
    }

    OUTCOME_MAP = {
        'X' => 0,
        'Y' => 3,
        'Z' => 6
    }

    def initialize(file_name)
        @file_name = file_name
        @encrypted_moves = []
        @scores = []
    end

    def load_day_1
        parse_file
        calculate_scores
        @scores
    end

    def load_day_2
        parse_file
        calculate_scores_with_outcomes
        @scores
    end

    def parse_file
        file = File.open(@file_name, 'r')
        file.each_line(chomp: true) do |line|
            @encrypted_moves << line.split(' ')
        end
    end

    def decrypted_moves
        @encrypted_moves.map do |arr|
            arr.map do |char|
                PLAY_MAP[char]
            end
        end
    end

    def decrypted_moves_and_outcomes
        @encrypted_moves.map do |arr|  
            [PLAY_MAP[arr[0]], OUTCOME_MAP[arr[1]]]
        end
    end

    def calculate_scores
        decrypted_moves.each do |arr|
            my_play = arr[1]
            @scores << SCORE_MAP[arr.join] + PLAY_VALUE_MAP[my_play]
        end
    end

    def calculate_scores_with_outcomes
        # Array of elf plays and desired outcomes
        # Example: [['R', 0], ['P', 3], ['S', 6]]
        decrypted_moves_and_outcomes.each do |arr|
            elf_play = arr[0]
            desired_outcome = arr[1]

            play_score = SCORE_MAP.filter { |k, v| k.start_with?(elf_play)}
                                    .filter { |k, v| v == desired_outcome } 
            my_play = play_score.keys.first[1]

            @scores << SCORE_MAP[play_score.keys.first] + PLAY_VALUE_MAP[my_play]
        end
    end
end

p 'Part 1 Results (Example and Puzzle Input)'
p RockPaperScissors.new('example.txt').load_day_1.sum
p RockPaperScissors.new('input.txt').load_day_1.sum

p 'Part 2 Results (Example and Puzzle Input)'
p RockPaperScissors.new('example.txt').load_day_2.sum
p RockPaperScissors.new('input.txt').load_day_2.sum