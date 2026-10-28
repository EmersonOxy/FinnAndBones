extends SceneTree
const Store=preload("res://scripts/data_store.gd")
const Model=preload("res://scripts/game_model.gd")
const Timeline=preload("res://scripts/battle_timeline.gd")
var failures=0
func check(x:bool, text:String):
    if x: print("PASS: ",text)
    else: failures+=1; push_error("FAIL: "+text)
func _initialize():
    var data=Store.new()
    check(data.load_all(),"dados")
    var m=Model.new(data)
    m.equip(0,"weapon")
    m.start_first()
    m.enemy.BaseLuck=5
    var t=Timeline.new(m)
    var contacts=[0]
    t.contact.connect(func(_result): contacts[0]+=1)
    t.start()
    t.step(12.0/30.0)
    check(m.enemy_hp==38 and t.state=="animating", "dano não ocorre antes do marcador hit")
    t.step(1.0/30.0)
    check(m.enemy_hp<38 and m.turn=="enemy", "dano aplicado no quadro hit")
    check(contacts[0]==1 and t.state=="animating", "um único contato por ataque")
    t.step(1.0/30.0)
    check(contacts[0]==1 and t.state=="animating", "contato não duplica durante a animação")
    t.step(19.0/30.0)
    check(t.state=="ready", "ataque de Finn termina no quadro 58")
    t.step(16.0/30.0)
    check(contacts[0]==2 and t.attacker=="enemy", "ataque inimigo contata no quadro 17")
    t.step(12.0/30.0)
    check(t.state=="animating" and t.attacker=="enemy", "aguarda ataque inimigo após seu último quadro")
    t.step(25.0/30.0)
    check(t.state=="animating", "aguarda o fim da reação de Finn")
    t.step(1.0/30.0)
    check(t.state=="ready", "reação termina antes do próximo turno")
    t.step(1.0/30.0)
    check(contacts[0]==2 and t.attacker=="finn", "próximo ataque só começa após ataque e reação")

    var sim_model=Model.new(data)
    sim_model.equip(0,"weapon")
    sim_model.start_first()
    var simulation=Timeline.new(sim_model)
    simulation.start()
    var sim=0
    while simulation.state!="stopped" and sim<2000:
        simulation.step(1.0/30.0)
        sim+=1
    check(simulation.state=="stopped" and (sim_model.phase=="victory" or sim_model.phase=="defeat"), "combate automático chega a resultado")
    print("RESULT: ",failures," falhas")
    quit(1 if failures else 0)
