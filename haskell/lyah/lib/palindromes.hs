main = interact respondPalindrome

respondPalindrome = unlines . map (\xs -> if isPalindrome xs then "Is a palindrome" else "Not a palindrome") . lines
    where    isPalindrome xs = xs == reverse xs