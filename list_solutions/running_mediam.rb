input = [12,4,5,3,8,7]

def median(input)
    medians = []
    input.each_with_index do |value, index|
        numbers = input[0..index]
        medians << calculate_median(numbers.sort)
    end 

    medians
end

def calculate_median(numbers)
    is_odd = numbers.size.odd?
    middle_index = numbers.size/2 

    is_odd ? numbers[middle_index] : (numbers[middle_index]+numbers[middle_index-1])/2.0
end

p median(input)