require 'byebug'

def recursive_range(start_num, end_num)
  return [] if end_num == start_num

  recursive_range(start_num, end_num - 1) << end_num - 1
end

# p recursive_range(1, 5) #should return [1, 2, 3, 4]

def iterative_range(start_num, end_num)
  result = []

  (start_num...end_num).each { |num| result << num}
  result
end

def exp1(base, power)
  return 1 if power == 0

  base * exp1(base, power - 1)
end

# p exp1(2, 3)

def exp2(base, n)
  return 1 if n == 0

  if n.even?
    exp2(base, n / 2) * exp2(base, n / 2)
  else
    base * (exp2(base, (n - 1) / 2) ** 2)
  end
end

# p exp2(2, 3)

class Array

  def deep_dup
    result = []

    self.each do |el|
      if el.is_a?(Array)
        result << el.deep_dup
      else
        result += [el]
      end
    end

    result
  end
end

# x = [1,2,3,[5,6,7],8,9]
# a = x.deep_dup
# p a
# p a.object_id == x.object_id 





def rec_fibo(n)
  return [1] if n == 1
  return [1, 1] if n == 2
  
  prev = rec_fibo(n - 1)
  prev << prev.last + rec_fibo(n - 2).last
end

# p rec_fibo(5) => 1,1,2,3,5




# Binary Search
# # The binary search algorithm begins by comparing the target value to 
# the value of the middle element of the sorted array. If the target 
# value is equal to the middle element's value, then the position is 
# returned and the search is finished. If the target value is less than 
# # the middle element's value, then the search continues on the lower half 
# # of the array; or if the target value is greater than the middle 
# # element's value, then the search continues on the upper half of the 
# array. This process continues, eliminating half of the elements, and 
# comparing the target value to the value of the middle element of the 
# remaining elements - until the target value is either found (and its 
# associated element position is returned), or until the entire array has 
# been searched (and "not found" is returned).

# Write a recursive binary search: bsearch(array, target). Note that 
# binary search only works on sorted arrays. Make sure to return the 
# location of the found object (or nil if not found!). Hint: you will 
# probably want to use subarrays.


def bsearch(arr, target)
  return nil if arr.empty?

  size = arr.length
  mid = size / 2 

  if target == arr[mid]
    return mid 
  elsif target > arr[mid]
    right = arr[(mid + 1)..-1]
    val_returned = bsearch(right, target)
    val_returned == nil ? (return nil) : val_returned + (mid + 1)
  else
    left = arr[0...mid]
    val_returned = bsearch(left, target)
    val_returned == nil ? (return nil) : val_returned
  end
end


# Make sure that these test cases are working:

p bsearch([1, 2, 3], 1) # => 0
p bsearch([2, 3, 4, 5], 3) # => 1
p bsearch([2, 4, 6, 8, 10], 6) # => 2
p bsearch([1, 3, 4, 5, 9], 5) # => 3
p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil




class Array
  def merge_sort(&prc)
    prc ||= Proc.new { |x, y| x <=> y }

    return self if self.count < 2
    mid = self.length / 2

    left, right = self.take(mid), self.drop(mid)
    left_sorted = left.merge_sort(&prc)
    right_sorted = right.merge_sort(&prc)

    Array.merge(left_sorted, right_sorted, &prc)
  end

  def self.merge(left, right, &prc)
    merged = []

    until left.empty? || right.empty?
      if prc.call(left.first, right.first) == 1
        merged << right.shift
      else
        merged << left.shift
      end
    end

    merged + left + right
  end
end

# p [1,6,2,6,8,4,2,6,8,0,6,5,42,5,78,9,531].merge_sort