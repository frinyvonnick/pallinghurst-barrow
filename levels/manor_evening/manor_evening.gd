extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var lines: Array = [
		{ character= "Mother", content= "You were on the barrow about seven, Mr Reeve. You watched the sunset close. How fast you must have walked home!" }, 
		{ character= "Mother", content= "I was almost half afraid you were going to be late for dinner." }, 
		{ character= "Rodolphe", content= "Oh, dear, no, Mrs Bouverie-Barton. I may be foolish, but not, I hope, criminal." }, 
		{ character= "Rodolphe", content= "I know better than to do anything so weak and wicked as that at Pallinghurst manor. I do walk rather fast, and the sunset - well, the sunset was just too lovely." }, 
		{ character= "Daughter", content= "It always is, this night every year." },
		{ character= "Daughter", content= "It is the night, you know, when the light burns bright on the Old Long Barrow." },
		{ character= "Mother", content= "What nonsense you talk, my child!" },
		{ character= "Narrator", content= "But the child's words, though lightly whispered, had caught the quick ear of Dr Porter, the distinguished Doctor." },
		{ character= "Doctor", content= "What's that, Joyce?" },
		{ character= "Daughter", content= "The autumnal equinox; that's just it." },
		{ character= "Daughter", content= "Old Rachel, the gipsy, told me it was Baal's night before it was St Michael's, and it was somebody else's night, whose name I forget, before it was Baal's." },
		{ character= "Daughter", content= "And the somebody was a god to whom you must never sacrifice anything with iron, but always with flint or with a stone hammer." },
		{ character= "Doctor", content= "Now, this is interesting. Profoundly interesting." },
		{ character= "Rodolphe", content= "Weel, whether Joyce has ever seen it or not. I can answer for it myself that I saw a very curious light on the Long Barrow tonight; and, furthermore, I felt a most peculiar sensation." }, 
		{ character= "Daughter", content= "Oh, I know, I know!" },
		{ character= "Daughter", content= "A sort of feeling that there was somebody somewhere, very faint and dim, though you couldn't see or hear them; they tried to pull you down." },
		{ character= "Daughter", content= "Oh, I know what all that is! I've been there, and felt it." },
		{ character= "Mother", content= "Joyce!" }, 
		{ character= "Rodolphe", content= "Doctor, my head begin to ache. Can't you give me anything to relieve it?" },
		{ character= "Doctor", content= "Oh, certainly. I'll bring you a draught that will put that all right in less than half an hour." },
		{ character= "Narrator", content= "Rodolph Reeve took the Doctor's medecine and went to sleep." }, 
	]
	DialogManager.start_dialog(lines)
	await DialogManager.dialog_finished
	get_tree().change_scene_to_file("res://levels/manor_night/manor_night.tscn")

