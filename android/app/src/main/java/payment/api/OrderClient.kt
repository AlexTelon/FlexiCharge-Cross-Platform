package payment.api



object OrderClient {

    private const val user = "PK44717_c4725bec1088" // please enter user here
    private const val password = "QnkVkiprxTaA3aDN" // please enter password here
   
    private const val baseUrl = "https://api.playground.klarna.com/" // please update the url according to your location and desired environment (playground, production)
    fun hasSetCredentials() = user.isNotBlank() && password.isNotBlank()
}