function EnvoyerMessage {
     param(
        [string]$cnl,
        [string]$msg
    )
    $slackToken = "xoxb-5431437001842-5572288696579-ZqtDwwgKwW7KW8bRJFjuEkZc"
    $sortie=""

    $message = @{
        channel = $cnl
        text = $msg
        link_names = $true
        mrkdwn = $true
    } | ConvertTo-Json

    $url = "https://slack.com/api/chat.postMessage"

    $headers = @{
        "Authorization" = "Bearer $slackToken"
        "Content-Type" = "application/json"
    }

    $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Post -Body $message

    if ($response.ok) {
        $sortie = "Message envoyé avec succès à Slack."
    } else {
        $sortie = "Erreur lors de l'envoi du message à Slack : $($response.error)"
    }
    return $sortie
}