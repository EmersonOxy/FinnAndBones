extends SceneTree
const ROOT="C:/Projetos/FinnAndBonesPreservation/assets/sprites/"
func _initialize():
    var sets = [
        ["finn/sprites/DefineSprite_500_assets.FinnSword", "finn_sword", 1, 169],
        ["finn/sprites/DefineSprite_500_assets.FinnSword", "finn_sword", 252, 410],
        ["finn/sprites/DefineSprite_243_assets.FinnHand", "finn_hand", 1, 180],
        ["enemy1_normal/sprites/DefineSprite_55_assets.enemy1_normal.idle", "enemy_idle", 1, 21],
        ["enemy1_normal/sprites/DefineSprite_96_assets.enemy1_normal.hurt", "enemy_hurt", 1, 18],
        ["enemy1_normal/sprites/DefineSprite_103_assets.enemy1_normal.evade", "enemy_evade", 1, 25],
        ["enemy1_normal/sprites/DefineSprite_120_assets.enemy1_normal.attack", "enemy_attack", 1, 29],
        ["enemy1_normal/sprites/DefineSprite_121_assets.enemy1_normal.die", "enemy_die", 1, 18],
        ["backgrounds/sprites/DefineSprite_41_assets.background", "background", 1, 1]
    ]
    var fails=0
    for entry in sets:
        var dest="res://private/frames/"+entry[1]
        DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(dest))
        for i in range(entry[2],entry[3]+1):
            var path=ROOT+entry[0]+"/"+str(i)+".svg"
            var img=Image.new()
            var err=img.load_svg_from_buffer(FileAccess.get_file_as_bytes(path),0.35)
            if err!=OK:
                fails+=1
                print("FAIL ",path," ",err)
                continue
            err=img.save_png(dest+"/"+str(i)+".png")
            if err!=OK: fails+=1
        print("done ",entry[1]," ",entry[2],"-",entry[3])
    print("errors=",fails)
    quit(1 if fails else 0)
