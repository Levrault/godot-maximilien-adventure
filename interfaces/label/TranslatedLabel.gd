# Translate a label
extends Label
class_name TranslatedLabel

var locale_key := ""


func _ready() -> void:
	SettingsManager.connect("retranslate", self, "retranslate")
	locale_key = text
	text = TranslationServer.translate(locale_key)


# Refresh and retranslate text
func retranslate() -> void:
	text = TranslationServer.translate(locale_key)
