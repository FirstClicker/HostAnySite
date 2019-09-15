<%@ Control Language="VB" ClassName="ContactUs" %>
<%@ Register Src="~/App_Controls/ReCaptcha.ascx" TagPrefix="uc1" TagName="ReCaptcha" %>


<script runat="server">
    Protected Sub SubmitFeedback_Click(sender As Object, e As EventArgs)
        If ReCaptcha.validCaptcha = False Then Exit Sub

        Dim submitfeedback As FirstClickerService.Version1.Feedback.StructureFeedback = FirstClickerService.Version1.Feedback.SubmitFeedback(TextboxFeedbackEmail.Text, TextboxFeedbackNAME.Text, TextboxFeedbackPhone.Text, TextboxFeedbackAddress.Text, FirstClickerService.Version1.Feedback.FeedbackType.General, WebAppSettings.WebSiteName, TextboxFeedbackHeading.Text, TextboxFeedbackMmessage.Text, "0", WebAppSettings.DBCS)
        If submitfeedback.Result = True Then
            PanelFeedbackResponse.Visible = True
            PanelFeedbackForm.Visible = False

            TextboxFeedbackEmail.Text = ""
            TextboxFeedbackNAME.Text = ""
            TextboxFeedbackPhone.Text = ""
            TextboxFeedbackAddress.Text = ""
            TextboxFeedbackHeading.Text = ""
            TextboxFeedbackMmessage.Text = ""
        Else
            LabelFeedbackEM.Text = submitfeedback.My_Error_message
        End If
    End Sub

    Protected Sub ButtonFeedbackReset_Click(sender As Object, e As EventArgs)
        PanelFeedbackResponse.Visible = False
        PanelFeedbackForm.Visible = True
    End Sub

</script>

<div class="card">
    <div class="card-header clearfix">
        <div class="text-center" >
            <h4 class="card-title">Do you have any questions?</h4>
            <h5 class="card-subtitle">Please fill out the form below.</h5>
        </div>
    </div>
    <asp:Panel runat="server" ID="PanelFeedbackForm" CssClass="card-body">
        <div class="row">
            <div class="col-12">
                <div>
                    <div class="form-group">
                        <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                        <span class="sr-only"></span>
                        <label for="inputName">Name</label>
                        <asp:TextBox runat="server" CssClass="form-control" ID="TextboxFeedbackNAME" placeholder="Please enter your full name" />
                    </div>
                    <div class="form-group ">
                        <span class="glyphicon glyphicon-earphone" aria-hidden="true"></span>
                        <span class="sr-only"></span>
                        <label for="inputNumber">Phone</label>
                        <asp:TextBox runat="server" CssClass="form-control" ID="TextboxFeedbackPhone" placeholder="Phone Number" />
                    </div>
                </div>
            </div>

        </div>
        <div class="row">
            <div class="col-12">
                <div>
                    <div class="form-group">
                        <span class="glyphicon glyphicon-envelope" aria-hidden="true"></span>
                        <span class="sr-only"></span>
                        <label for="inputEmail">Email</label>
                        <asp:TextBox runat="server" CssClass="form-control" ID="TextboxFeedbackEmail" placeholder="Email" />
                    </div>
                    <div class="form-group">
                        <span class="glyphicon glyphicon-home" aria-hidden="true"></span>
                        <span class="sr-only"></span>
                        <label for="inputAddress">Address</label>
                        <asp:TextBox runat="server" CssClass="form-control" ID="TextboxFeedbackAddress" placeholder="Full Address" />
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div>
                    <div class="form-group">
                        <span class="fas fa-pencil" aria-hidden="true"></span>
                        <span class="sr-only"></span>
                        <label for="inputEmail">Type</label>
                        <asp:DropDownList ID="DropDownListFeedbackType" CssClass="form-control" runat="server">
                            <asp:ListItem>General</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div>
                    <div class="form-group">
                        <span class="fas fa-pencil" aria-hidden="true"></span>
                        <span class="sr-only"></span>
                        <label for="inputEmail">Subject</label>
                        <asp:TextBox runat="server" CssClass="form-control" ID="TextboxFeedbackHeading" placeholder="Subject" />
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div>
                    <div class="form-group">
                        <span class="fas fa-pencil" ></span>
                        <span class="sr-only"></span>
                        <label for="inputMessage">Enter Your message</label>
                        <asp:TextBox runat="server" CssClass="form-control" ID="TextboxFeedbackMmessage" placeholder="Enter your message" Rows="5" TextMode="MultiLine" />
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div>
                    <div class="form-group">
                        <uc1:ReCaptcha runat="server" ID="ReCaptcha" />
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-sm-12">
                <div>
                    <div class="form-group">
                        <asp:Label ID="LabelFeedbackEM" CssClass="" runat="server" Text=""></asp:Label>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <div>
                    <div class="form-group">
                        <asp:Button runat="server" ID="SubmitFeedback" type="button" CssClass="btn btn-info pull-right" OnClick="SubmitFeedback_Click" Text="Contact Us"></asp:Button>
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>

    <asp:Panel runat="server" ID="PanelFeedbackResponse" CssClass="card-body" Visible="false">
        <div class="row">
            <div class="col-sm-12">
                <asp:Image ID="Image1" runat="server" CssClass="img-fluid" ImageUrl="http://firstclicker.com/Content/images/Thank-You-For-Contacting-Us.png" />
            </div>
            <div class="col-sm-12">
                <asp:Button ID="ButtonFeedbackReset" runat="server" Text="Back" OnClick="ButtonFeedbackReset_Click" />
            </div>
        </div>
    </asp:Panel>
</div>

