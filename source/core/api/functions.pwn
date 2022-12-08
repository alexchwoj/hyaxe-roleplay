#if defined _api_functions_
    #endinput
#endif
#define _api_functions_

API_SendWebhook(const message[], color, const emoji[] = "no-emoji", const title[] = "no-title")
{
	new payload[1024];
	format(payload, sizeof(payload), "{\"message\": \"%s\", \"emoji\": \"%s\", \"color\": \"%x\", \"title\": \"%s\"}", message, emoji, color, title);
	HTTP(0, HTTP_POST, "134.255.218.239:5000/api/send_webhook", payload, "");
	return 1;
}

API_UpdateWeather(weather_id)
{
	new payload[32];
	format(payload, sizeof(payload), "{\"weather\": \"%s\"}", weather_id);
	HTTP(0, HTTP_POST, "134.255.218.239:5000/api/update_weather", payload, "");
	return 1;
}