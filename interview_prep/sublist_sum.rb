def find_largest_sum(list)
  current_sum = 0
  global_max = 0

  list.each do |num|
    current_sum += num
    global_max = current_sum if current_sum > global_max
    current_sum = 0 if current_sum < 0
  end

  global_max
end


raise RuntimeError.new if find_largest_sum([2, 4, 3, -2, 1]) != 9
raise RuntimeError.new if find_largest_sum([-5, 2, 4, 3, -2, 1]) != 9
raise RuntimeError.new if find_largest_sum([-5, 2, 4, -10, 9, -2, 1]) != 9
raise RuntimeError.new if find_largest_sum([-5, 2, 4, -1, 4, -2, 1]) != 9

# differnet problem though, no?
# that's a solution to lights-out
# no. my problem was find all the neighboring cells with the same value.
# lights out is a game that has special rules.

# sorry. rose told me threyre the same... mmm, not sure. need to look a littel closer
# my initial impression is that they're different.

# mine was just a flood-fill algo.
# about our d3 stuff. i think i'm going to work backwards on that one. i'm going to find a cool
# d3 library then see what we can do with that. because i think i'm getting nowherre by focusing
# on what algo to visualisze

# there's something i might need to do next week, so i'm not sure i can spend a ton of time on the d3 stuff...
# i'm supposed to beta test this coursera course... second part to nand2tetris
# thats fine - i can work alone ion parts, and you can come in when your free'
#and you finished nand2tret
# sounds good.

# she said leave some m&ms for the pomodoro group
# i said, "what m&ms?" i didn't see any...