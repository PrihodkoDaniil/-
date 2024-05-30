extends Area2D


@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

func action():
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)

func _ready():
	if State.druid1act == true and State.bossdragon2act == true and State.boss4actlibrarian == true:
		dialogue_resource = load("res://dialogues/good_ending.dialogue")
	elif State.druid1act == true or State.bossdragon2act == true or State.boss4actlibrarian == true:
		dialogue_resource = load("res://dialogues/neutral_ending.dialogue")
	elif State.druid1act == false and State.bossdragon2act == false and State.boss4actlibrarian == false:
		dialogue_resource = load("res://dialogues/bad_ending.dialogue")
