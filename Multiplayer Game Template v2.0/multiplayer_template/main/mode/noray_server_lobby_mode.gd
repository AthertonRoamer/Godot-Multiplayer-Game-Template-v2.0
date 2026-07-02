class_name NorayServerLobbyMode
extends NorayLobbyMode

#basically noray lobby mode that can be controlled directly and without a lobby manager

var matchmaker : Matchmaker

func _init() -> void:
	id = "noray_server_lobby"
	tag_list.append("lobby")


func open() -> void:
	default_port = Network.port #save default port for later
	noray_manager = NorayManager.new()
	matchmaker = Main.main.matchmaker_scene.instantiate() #
	Main.main.add_child(matchmaker, true)
	if Main.has_arg_option("--custom-noray-ip"):
		noray_manager.custom_noray_server_ip = Main.get_arg_option_parameter("--custom-noray-ip")
	Main.main.add_child(noray_manager, true)
	lobby = Main.main.lobby_scene.instantiate()
	lobby.is_master = true
	Main.main.add_child(lobby, true)
	
	#lobby_manager = Main.main.lobby_manager_scene.instantiate()
	#Main.main.add_child(lobby_manager, true)
	
	Main.output("Opening noray server lobby mode")


func close() -> void:
	Network.port = default_port #restore default port
	#lobby_manager.close_peer()
	#lobby_manager.queue_free()
	lobby.queue_free()
	noray_manager.queue_free()
	Network.close_peer()
	Main.output("Closing noray server lobby mode")
