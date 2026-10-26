extends Node2D

var test_var: int = 5


func _ready() -> void:
	var test_var: int = 20 # integer, whoel numbers
	var test_var2: String = "aaaa" # words and letters 
	
	var test_var4: bool = false # could also be false 
	# var test_var4 = player
	# var test_var5 = 

	var test_var3: int = 8 # numbers with decimals
	if test_var3 < 5:
		print("a") 
	elif test_var3 == 10: #else if
		print("b")
	elif test_var3 == 15:
		print("c")
	elif test_var3 < 20:
		print("d")
	else:
		print("e")
	
	for y in range(6):
	# when i is 0, 1, 2, 3, 4, 5, do the inside thing and then add 1 to i
		var line = ""
		for x in range(4):
			line = line + "o"
		print(line)
	print("done")
	
	for i in range(10):
		print(i)
	print("--done--")
	
	var i: int = 1
	while i < 1000000:
		print(i)
		i = i * 10
	print("--done2--")
	
	print(i)
	
	#goal : print 5 'a's and then a 'b' and then 5 more 'a's and then a 'c'
	print_as("b")
	
	print("hello ")
	
	print_as("c")
	print_as("d")
	
	for k in range(98, 101):
		for j in range(5):
			print("a")
		print(char(k))
	print(int("a"))
	print(char(65))

func print_as(extra_letter):
	for j in range(5):
		print("a")
	print(extra_letter)
