# Translate a label
extends Label
class_name TranslatedLabel

var locale_key := ""


func _ready() -> void:
	SettingsManager.connect("retranslate", self, "_on_Retranslate")
	locale_key = text
	text = TranslationServer.translate(locale_key)


# Refresh and retranslate text
func _on_Retranslate() -> void:
	text = TranslationServer.translate(locale_key)
