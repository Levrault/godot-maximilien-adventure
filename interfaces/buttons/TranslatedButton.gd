"""
Button with translation
"""
extends Button
class_name TranslatedButton

var locale_key := ""


func _ready():
	SettingsManager.connect("retranslate", self, "_on_Retranslate")
	text = TranslationServer.translate(text)


"""
Refresh and retranslate text
"""
func _on_Retranslate() -> void:
	text = TranslationServer.translate(locale_key)
