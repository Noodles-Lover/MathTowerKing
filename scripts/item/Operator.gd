class_name Operator
extends Item

enum OP_TYPE{
	PLUS = 10,
	MINUS = 11,
	MUTLIPLY = 12,
	DIVIDE = 13
}

var type: OP_TYPE
var symbol: String

func _init(type: OP_TYPE):
	self.type = type
	self.symbol = enum2symbol(type)


func getValue():
	return type
	
func calculate(a:int, b:int):
#	var a = numA.value
#	var b = numB.value
	
	match (type):
		OP_TYPE.PLUS:
			return a+b
		OP_TYPE.MINUS:
			if (a-b <= 0): return 0
			return a-b
		OP_TYPE.MUTLIPLY:
			return a*b
		OP_TYPE.DIVIDE:
			return floor(a/b)

static func newBySymbol(symbol):
	match symbol:
		"+":
			return Operator.new(OP_TYPE.PLUS)
		"-":
			return Operator.new(OP_TYPE.MINUS)
		"*":
			return Operator.new(OP_TYPE.MUTLIPLY)
		"/":
			return Operator.new(OP_TYPE.DIVIDE)
		_:
			print("!! newBySymbol not match")
#			return Operator.new(OP_TYPE.PLUS)
			return null

static func newByString(str):
	match str:
		"PLUS":
			return Operator.new(OP_TYPE.PLUS)
		"MINUS":
			return Operator.new(OP_TYPE.MINUS)
		"MUTLIPLY":
			return Operator.new(OP_TYPE.MUTLIPLY)
		"DIVIDE":
			return Operator.new(OP_TYPE.DIVIDE)
		_:
			print("!! newByString not match")
#			return Operator.new(OP_TYPE.PLUS)
			return null
			
# 仅支持四则运算符号
func getScene():
	var scene = load("res://scenes/part_of/symbol.tscn").instantiate()
	scene.symbol = symbol
	return scene

static func getRandomOpType():
	var ops = OP_TYPE.values()  # 获取枚举的所有值
	var random_index = randi() % ops.size()  # 生成一个随机索引
	return ops[random_index]
		
const symbolEnumArray = ["+", "-", "*", "/", 
						OP_TYPE.PLUS, 
						OP_TYPE.MINUS, 
						OP_TYPE.MUTLIPLY, 
						OP_TYPE.DIVIDE]
		
static func symbol2enum(symbol) -> OP_TYPE:
	return symbolEnumExchange(symbol)

#static func string2symbol(str) -> String:
#	return symbolEnumExchange(str)
	
static func enum2symbol(type) -> String:
	return symbolEnumExchange(type)

static func symbolEnumExchange(text):
	if symbolEnumArray.find(text) < 0: return ""
	var newIndex = (symbolEnumArray.find(text) + 4) % len(symbolEnumArray)
	return symbolEnumArray[newIndex]
