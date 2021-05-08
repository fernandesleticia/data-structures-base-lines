brackets_string = '{[((])]}'
@symbols = { '{' => '}', '[' => ']', '(' => ')' }

def is_balanced(brackets_string)
    brackets = brackets_string.split('')
    verify(brackets)
end

def verify(brackets)
    return true if brackets.empty?

    brackets_length = brackets.length
    new_length = brackets_length - 2
    left_bracket = brackets[0]
    right_bracket = brackets[brackets_length-1]

    is_balanced = right_bracket == @symbols[left_bracket]
    
    verify(brackets[1,new_length]) && is_balanced
end

is_balanced(brackets_string)