package payment.api

import okhttp3.OkHttpClient
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory


object OrderClient {

    private const val user = "PK44724_d698c30a2ecf" // please enter user here
    private const val password = "W3qbzPElv3tCIdyt" // please enter password here
    private const val baseUrl = "https://api.playground.klarna.com/" // please update the url according to your location and desired environment (playground, production)
    fun hasSetCredentials() = user.isNotBlank() && password.isNotBlank()
}