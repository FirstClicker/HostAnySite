<%@ Control Language="VB" ClassName="AdsenseAds" %>

<script runat="server">
    Enum ad_format
        auto
        rectangle
        vertical
        horizontal
    End Enum

    Public Property Adsformat() As ad_format
        Get
            Return [Enum].Parse(GetType(ad_format), LabelAdsformat.Text, True)
        End Get
        Set(ByVal value As ad_format)
            LabelAdsformat.Text = value.ToString
        End Set
    End Property

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If Trim(WebAppSettings.GoogleAdsense_DataAdClient) = "" Then
            Me.Visible = False
        End If
    End Sub
</script>


<asp:Label ID="LabelAdsformat" runat="server" Text="auto" Visible="False"></asp:Label>
<div class="card mt-2 mb-3">
    <div class="card-body p-0">
        <script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
        <!-- Sayzz Responsive Ads -->
        <ins class="adsbygoogle"
            style="display: block"
            data-ad-client="<%=WebAppSettings.GoogleAdsense_DataAdClient %>"
            data-ad-slot="<%=WebAppSettings.GoogleAdsense_DataAdSlot %>"
            data-ad-format="<%=Adsformat.ToString  %>"></ins>
        <script>
            (adsbygoogle = window.adsbygoogle || []).push({});
        </script>
    </div>
</div>


