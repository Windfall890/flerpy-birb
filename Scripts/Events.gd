extends Node

signal GameStart()
signal GameEnd()
signal PointScored()
signal IncreaseDifficulty()

#UI
signal Tick(accumulator: float)
signal ScoreChanged(score:int)
