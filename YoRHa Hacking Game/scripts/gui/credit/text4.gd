#credit text3
extends Control

### variable
var text1_step = []
var text2_step = []
var text3_step = []
var text4_step = []
var text5_step = []
var text6_step = []
var text7_step = []
var text8_step = []
var text9_step = []
var text10_step = []
var text11_step = []
var text12_step = []

### child node
onready var text1 = get_node("text1")
onready var text2 = get_node("text2")
onready var text3 = get_node("text3")
onready var text4 = get_node("text4")
onready var text5 = get_node("text5")
onready var text6 = get_node("text6")
onready var text7 = get_node("text7")
onready var text8 = get_node("text8")
onready var text9 = get_node("text9")
onready var text10 = get_node("text10")
onready var text11 = get_node("text11")
onready var text12 = get_node("text12")

### anim
onready var anim = utils.main_node().get_node("anim")

### start state
var start = false
var start_prev = false
var start_next = false

### count status
var count1 = 0
var count1_stat = true
var count2 = 0
var count2_stat = false
var count3 = 0
var count3_stat = false
var count4 = 0
var count4_stat = false
var count5 = 0
var count5_stat = false
var count6 = 0
var count6_stat = false
var count7 = 0
var count7_stat = false
var count8 = 0
var count8_stat = false
var count9 = 0
var count9_stat = false
var count10 = 0
var count10_stat = false
var count11 = 0
var count11_stat = false
var count12 = 0
var count12_stat = false

### sfx
onready var sample_player = utils.main_node().get_node("sample_player")

var delay = false
var delay_count = 0

var delay2 = false
var delay2_count = 0

export (NodePath) var next_sceneP
onready var next_scene = get_node(next_sceneP)

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	scene_variable()
	start_prev = start
	start = start_next
	
	if start == true:
		self.show()
		scene(delta)
	elif start == false:
		self.hide()
	pass

func scene(delta):
	if count1_stat == true:
		text1.show()
		count1 += ((1.5*delta)*12.5)
		if count1 < 5:
			text1.set_text(text1_step[count1])
			sample_player.play("type")
		elif count1 > 7:
			count2_stat = true
			count1_stat = false
	elif count1_stat == false:
		count1 = 0
	
	if count2_stat == true:
		text2.show()
		count2 += ((1.5*delta)*12.5)
		if count2 < 2:
			text2.set_text(text2_step[count2])
			sample_player.play("type")
		elif count2 > 4:
			count3_stat = true
			count2_stat = false
	elif count2_stat == false:
		count2 = 0
	
	if count3_stat == true:
		text3.show()
		count3 += ((1.5*delta)*12.5)
		if count3 < 5:
			text3.set_text(text3_step[count3])
			sample_player.play("type")
		elif count3 > 9:
			anim.play("scene4A")
			delay = true
			count3_stat = false
	elif count3_stat == false:
		count3 = 0
	
	if delay == false:
		delay_count = 0
	elif delay == true:
		delay_count += 1
		if delay_count == 100:
			count4_stat = true
			delay = false
	
	if count4_stat == true:
		text4.show()
		count4 += ((1.5*delta)*12.5)
		if count4 < 14:
			text4.set_text(text4_step[count4])
			sample_player.play("type")
		elif count4 > 16:
			count5_stat = true
			count4_stat = false
	elif count4_stat == false:
		count4 = 0
	
	if count5_stat == true:
		text5.show()
		count5 += ((1.5*delta)*12.5)
		if count5 < 17:
			text5.set_text(text5_step[count5])
			sample_player.play("type")
		elif count5 > 19:
			count6_stat = true
			count5_stat = false
	elif count5_stat == false:
		count5 = 0
	
	if count6_stat == true:
		text6.show()
		count6 += ((1.5*delta)*12.5)
		if count6 < 16:
			text6.set_text(text6_step[count6])
			sample_player.play("type")
		elif count6 > 18:
			count7_stat = true
			count6_stat = false
	elif count6_stat == false:
		count6 = 0
	
	if count7_stat == true:
		text7.show()
		count7 += ((1.5*delta)*12.5)
		if count7 < 13:
			text7.set_text(text7_step[count7])
			sample_player.play("type")
		elif count7 > 15:
			count8_stat = true
			count7_stat = false
	elif count7_stat == false:
		count7 = 0
	
	if count8_stat == true:
		text8.show()
		count8 += ((1.5*delta)*12.5)
		if count8 < 17:
			text8.set_text(text8_step[count8])
			sample_player.play("type")
		elif count8 > 19:
			count9_stat = true
			count8_stat = false
	elif count8_stat == false:
		count8 = 0
	
	if count9_stat == true:
		text9.show()
		count9 += ((1.5*delta)*12.5)
		if count9 < 19:
			text9.set_text(text9_step[count9])
			sample_player.play("type")
		elif count9 > 21:
			anim.play("scene4B")
			delay2 = true
			count9_stat = false
	elif count9_stat == false:
		count9 = 0
	
	if delay2 == false:
		delay2_count = 0
	elif delay2 == true:
		delay2_count += 1
		if delay2_count == 60:
			count10_stat = true
			delay2 = false
	
	if count10_stat == true:
		text10.show()
		count10 += ((1.5*delta)*12.5)
		if count10 < 14:
			text10.set_text(text10_step[count10])
			sample_player.play("type")
		elif count10 > 16:
			count11_stat = true
			count10_stat = false
	elif count10_stat == false:
		count10 = 0
	
	if count11_stat == true:
		text11.show()
		count11 += ((1.5*delta)*12.5)
		if count11 < 16:
			text11.set_text(text11_step[count11])
			sample_player.play("type")
		elif count11 > 18:
			count12_stat = true
			count11_stat = false
	elif count11_stat == false:
		count11 = 0
	
	if count12_stat == true:
		text12.show()
		count12 += ((1.5*delta)*12.5)
		if count12 < 14:
			text12.set_text(text12_step[count12])
			sample_player.play("type")
		elif count12 > 51:
			next_scene.start_next = true
			start_next = false
			count12_stat = false
	elif count12_stat == false:
		count12 = 0
	
	pass

func scene_variable():
	text1_step = ["[S]_", 
				"[S]o_", 
				"[S]ou_", 
				"[S]oun_", 
				"[S]ound "]
	text2_step = ["[&]_",
				"[&] "]
	text3_step = ["[M]_",
				"[M]u_", 
				"[M]us_", 
				"[M]usi_", 
				"[M]usic "]
	text4_step = ["A_",
				"Am_", 
				"Amu_", 
				"Amus_", 
				"Amuse_", 
				"Amusem_", 
				"Amuseme_", 
				"Amusemen_", 
				"Amusement_", 
				"Amusement _",
				"Amusement P_",
				"Amusement Pa_",
				"Amusement Par_",
				"Amusement Park "]
	text5_step = ["W_",
				"Wr_", 
				"Wre_", 
				"Wret_", 
				"Wretc_", 
				"Wretch_", 
				"Wretche_", 
				"Wretched_", 
				"Wretched _", 
				"Wretched W_",
				"Wretched We_",
				"Wretched Wea_",
				"Wretched Weap_",
				"Wretched Weapo_",
				"Wretched Weapon_",
				"Wretched Weaponr_",
				"Wretched Weaponry "]
	text6_step = ["A_",
				"A _", 
				"A B_", 
				"A Be_", 
				"A Bea_", 
				"A Beau_", 
				"A Beaut_", 
				"A Beauti_", 
				"A Beautif_", 
				"A Beautifu_",
				"A Beautiful_",
				"A Beautiful _",
				"A Beautiful S_",
				"A Beautiful So_",
				"A Beautiful Son_",
				"A Beautiful Song "]
	text7_step = ["D_",
				"Da_", 
				"Dar_", 
				"Dark_", 
				"Dark _", 
				"Dark C_", 
				"Dark Co_", 
				"Dark Col_", 
				"Dark Colo_", 
				"Dark Colos_",
				"Dark Coloss_",
				"Dark Colossu_",
				"Dark Colossus "]
	text8_step = ["E_",
				"En_", 
				"End_", 
				"End O_", 
				"End Of_", 
				"End Of _", 
				"End Of T_", 
				"End Of Th_", 
				"End Of The_", 
				"End Of The _",
				"End Of The U_",
				"End Of The Un_",
				"End Of The Unk_",
				"End Of The Unkn_",
				"End Of The Unkno_",
				"End Of The Unknow_",
				"End Of The Unknown "]
	text9_step = ["W_",
				"We_", 
				"Wei_", 
				"Weig_", 
				"Weigh_", 
				"Weight_", 
				"Weight _", 
				"Weight O_", 
				"Weight Of_", 
				"Weight Of _",
				"Weight Of T_",
				"Weight Of Th_",
				"Weight Of The_",
				"Weight Of The _",
				"Weight Of The W_",
				"Weight Of The Wo_",
				"Weight Of The Wor_",
				"Weight Of The Worl_",
				"Weight Of The World "]
	text10_step = ["R_",
				"Re_", 
				"Reb_", 
				"Rebi_", 
				"Rebir_", 
				"Rebirt_", 
				"Rebirth_", 
				"Rebirth _", 
				"Rebirth &_", 
				"Rebirth & _",
				"Rebirth & H_",
				"Rebirth & Ho_",
				"Rebirth & Hop_",
				"Rebirth & Hope "]
	text11_step = ["F_",
				"Fo_", 
				"For_", 
				"Fort_", 
				"Fortr_", 
				"Fortre_", 
				"Fortres_", 
				"Fortress_", 
				"Fortress _", 
				"Fortress O_",
				"Fortress Of_",
				"Fortress Of _",
				"Fortress Of L_",
				"Fortress Of Li_",
				"Fortress Of Lie_",
				"Fortress Of Lies "]
	text12_step = ["B_",
				"Bl_", 
				"Bli_", 
				"Blis_", 
				"Bliss_", 
				"Blissf_", 
				"Blissfu_", 
				"Blissful_", 
				"Blissful _", 
				"Blissful D_",
				"Blissful De_",
				"Blissful Dea_",
				"Blissful Deat_",
				"Blissful Death "]
	pass