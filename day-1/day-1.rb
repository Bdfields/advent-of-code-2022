class Elf 
    def initialize(file_name)
        @calories = [[]]
        @file_name = file_name
    end

    def max_calories
        read_file
        calculate_total_calories
        [@calories.max, top_n(3).sum]
    end

    def read_file
        file = File.open(@file_name, 'r')
        file.each_line(chomp: true) do |line|
        if line.empty? 
            @calories << []
            next
        end
            @calories.last << line.to_i 
        end
    end

    def calculate_total_calories
        @calories.map! do |arr|
            arr.sum
        end
    end

    def top_n(n)
        @calories.sort.last(n)
    end
end

p Elf.new('example.txt').max_calories
p Elf.new('input.txt').max_calories
