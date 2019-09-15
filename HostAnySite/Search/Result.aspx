<%@ Page Title="" Language="VB" MasterPageFile="~/default.master" %>


<script runat="server">
    Public Property GoogleCSE_cxID() As String
        Get
            Return LabelGoogleCSE_cxID.Text
        End Get
        Set(ByVal value As String)
            LabelGoogleCSE_cxID.Text = value
        End Set
    End Property


    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If WebAppSettings.GoogleCSE_IsEnabled = True Then
            PanelGooglesearch.Visible = True
            GoogleCSE_cxID = WebAppSettings.GoogleCSE_cxID
        Else
            PanelGooglesearch.Visible = False
            GoogleCSE_cxID = 0
        End If



    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .gsc-tabsArea > .gsc-tabHeader {
            height: 30px !important;
        }

        .gsc-selected-option-container {
            background-color: transparent;
            border: 1px solid #eee;
            border: 1px solid rgba(0, 0, 0, 0.1);
            border-radius: 2px;
            box-shadow: 0 1px 1px #eee;
            box-shadow: 0 1px 1px rgba(0,0,0,0.1);
            color: #444;
            cursor: default;
            font-size: 11px;
            font-weight: bold;
            height: 27px;
            line-height: 27px;
            max-width: 100% !important;
            min-width: 54px;
            outline: 0;
            padding: 0 28px 0 6px;
            position: relative;
            text-align: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="LabelGoogleCSE_cxID" runat="server" Text="0" Visible="false"></asp:Label>
    <div class="row">
        <div class="col-12">
            <asp:panel runat ="server" ID="PanelGooglesearch" cssclass="card">
                <div class="card-body">
                    <script>
                        (function () {
                            var cx = '<%= WebAppSettings.GoogleCSE_cxID %>';
                            var gcse = document.createElement('script');
                            gcse.type = 'text/javascript';
                            gcse.async = true;
                            gcse.src = 'https://cse.google.com/cse.js?cx=' + cx;
                            var s = document.getElementsByTagName('script')[0];
                            s.parentNode.insertBefore(gcse, s);
                        })();
                    </script>
                    <gcse:searchresults-only></gcse:searchresults-only>
                </div>
            </asp:panel>
        </div>
    </div>
</asp:Content>

