Imports Microsoft.VisualBasic
Imports System.Security.Cryptography
Imports System.Net
Imports System.IO
Imports Newtonsoft.Json

Public Class ClassTwitter

    Public Shared Function GetUserDetails(oauth_token As String, oauth_token_secret As String, oauth_consumer_key As String, oauth_consumer_secret As String, screen_name As String) As ClassTwitterUser
        screen_name = screen_name.ToLower
        Dim resource_url As String = "https://api.twitter.com/1.1/account/verify_credentials.json"

        ' oauth implementation details
        Dim oauth_version = "1.0"
        Dim oauth_signature_method = "HMAC-SHA1"

        ' unique request details
        Dim oauth_nonce = Convert.ToBase64String(New ASCIIEncoding().GetBytes(DateTime.Now.Ticks.ToString()))
        Dim timeSpan = DateTime.UtcNow - New DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc)
        Dim oauth_timestamp = Convert.ToInt64(timeSpan.TotalSeconds).ToString()


        ' create oauth signature
        Dim baseFormat = "include_email=true&oauth_consumer_key={0}&oauth_nonce={1}&oauth_signature_method={2}&oauth_timestamp={3}&oauth_token={4}&oauth_version={5}&screen_name={6}"
        Dim baseString = String.Format(baseFormat, oauth_consumer_key, oauth_nonce, oauth_signature_method, oauth_timestamp, oauth_token, oauth_version, Uri.EscapeDataString(screen_name))
        baseString = String.Concat("GET&", Uri.EscapeDataString(resource_url), "&", Uri.EscapeDataString(baseString))

        Dim compositeKey = String.Concat(Uri.EscapeDataString(oauth_consumer_secret), "&", Uri.EscapeDataString(oauth_token_secret))

        Dim oauth_signature As String
        Using hasher As New HMACSHA1(ASCIIEncoding.ASCII.GetBytes(compositeKey))
            oauth_signature = Convert.ToBase64String(hasher.ComputeHash(ASCIIEncoding.ASCII.GetBytes(baseString)))
        End Using

        ' create the request header
        Dim headerFormat = "OAuth oauth_nonce=""{0}"", oauth_signature_method=""{1}"", " + "oauth_timestamp=""{2}"", oauth_consumer_key=""{3}"", " + "oauth_token=""{4}"", oauth_signature=""{5}"", " + "oauth_version=""{6}"""

        Dim authHeader = String.Format(headerFormat, Uri.EscapeDataString(oauth_nonce), Uri.EscapeDataString(oauth_signature_method), Uri.EscapeDataString(oauth_timestamp), Uri.EscapeDataString(oauth_consumer_key), Uri.EscapeDataString(oauth_token), _
            Uri.EscapeDataString(oauth_signature), Uri.EscapeDataString(oauth_version))



        ServicePointManager.Expect100Continue = False

        ' make the request
        Dim postBody = "screen_name=" + Uri.EscapeDataString(screen_name) + "&" + "include_email=true"
        '
        resource_url += "?" + postBody
        Dim request As HttpWebRequest = DirectCast(WebRequest.Create(resource_url), HttpWebRequest)
        request.Headers.Add("Authorization", authHeader)
        request.Method = "GET"
        request.ContentType = "application/x-www-form-urlencoded"


        Dim objText As String
        Try
            Dim response = DirectCast(request.GetResponse(), HttpWebResponse)
            Dim reader = New StreamReader(response.GetResponseStream())
            objText = reader.ReadToEnd()
        Catch ex As Exception
            objText = ex.Message
        End Try

        Dim Friends As ClassTwitterUser = JsonConvert.DeserializeObject(Of ClassTwitterUser)(objText)

        Return Friends

    End Function

End Class
