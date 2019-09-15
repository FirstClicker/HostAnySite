<%@ Control Language="VB" ClassName="ComparisonCriteriaRatingVote" %>
<%@ Import Namespace ="System.Data.SqlClient" %>


<script runat="server">
    Public Property EntryID() As Long
        Get
            Return LabelEntryID.Text
        End Get
        Set(ByVal value As Long)
            LabelEntryID.Text = value
        End Set
    End Property

    Public Property CriteriaName() As String
        Get
            Return LabelCriteriaName.Text
        End Get
        Set(ByVal value As String)
            LabelCriteriaName.Text = value
        End Set
    End Property

    Public Property CriteriaID() As Long
        Get
            Return LabelCriteriaID.Text
        End Get
        Set(ByVal value As Long)
            LabelCriteriaID.Text = value
        End Set
    End Property

    Public Property RatingValue() As Long
        Get
            Return RatingEntryRate.CurrentRating
        End Get
        Set(ByVal value As Long)
            RatingEntryRate.CurrentRating = value
        End Set
    End Property


    Public Property Ratingmessage() As String
        Get
            Return TextBoxMessage.Text
        End Get
        Set(ByVal value As String)
            TextBoxMessage.Text = value
        End Set
    End Property

    Public Property RatingCount() As Long
        Get
            Return Val(LabelVoteCount.Text)
        End Get
        Set(ByVal value As Long)
            LabelVoteCount.Text = value
        End Set
    End Property

    Public Property RatingCountShow() As Boolean
        Get
            Return LabelVoteCountShow.Visible
        End Get
        Set(ByVal value As Boolean)
            LabelVoteCountShow.Visible = value
        End Set
    End Property


    Public Property RatingIsReadOnly() As Boolean
        Get
            Return RatingEntryRate.ReadOnly
        End Get
        Set(ByVal value As Boolean)
            RatingEntryRate.ReadOnly = value

            If value = True Then
                LiComment.Visible = False
            Else
                LiComment.Visible = True
            End If

        End Set
    End Property


    Protected Sub RatingEntryRate_Click(sender As Object, e As RatingEventArgs)
        Dim myConn As SqlConnection
        Dim myCmd As SqlCommand
        Dim myReader As SqlDataReader

        myConn = New SqlConnection(WebAppSettings.dbcs)
        myCmd = myConn.CreateCommand
        myConn.Open()


        Dim hasrating As Boolean = False

        If Val(Session("userid")) >= 1 Then
            myCmd.CommandText = "select Vote from Table_ComparisionEntryRating where (userid='" & Val(Session("userid")) & "') and (EntryID='" & EntryID & "') and (CriteriaID='" & CriteriaID & "')"
            myReader = myCmd.ExecuteReader

            hasrating = myReader.HasRows = True

            myReader.Close()
        Else
            Exit Sub
        End If


        If hasrating = False Then
            myCmd.CommandText = "insert into Table_ComparisionEntryRating (EntryID, CriteriaID, userid, vote, message, VoteDate) values('" & EntryID & "', '" & CriteriaID & "', '" & Val(Session("userid")) & "', '" & e.Value & "', '" & Ratingmessage.Replace("'", "''") & "', '" & Now.ToString("yyyy-MM-ddTHH:mm:ss") & "')"
        Else
            myCmd.CommandText = "update Table_ComparisionEntryRating set Vote='" & e.Value & "', message='" & Ratingmessage.Replace("'", "''") & "' where (userid='" & Val(Session("userid")) & "') and (EntryID='" & EntryID & "') and (CriteriaID='" & CriteriaID & "')"
        End If

        myReader = myCmd.ExecuteReader
        myReader.Close()
        myConn.Close()
    End Sub

    Protected Sub ButtonSaveMessage_Click(sender As Object, e As EventArgs)
        Dim myConn As SqlConnection
        Dim myCmd As SqlCommand
        Dim myReader As SqlDataReader

        myConn = New SqlConnection(WebAppSettings.dbcs)
        myCmd = myConn.CreateCommand
        myConn.Open()


        Dim hasrating As Boolean = False

        If Val(Session("userid")) >= 1 Then
            myCmd.CommandText = "select Vote from Table_ComparisionEntryRating where (userid='" & Val(Session("userid")) & "') and (EntryID='" & EntryID & "') and (CriteriaID='" & CriteriaID & "')"
            myReader = myCmd.ExecuteReader

            hasrating = myReader.HasRows = True

            myReader.Close()
        Else
            Exit Sub
        End If


        If hasrating = False Then
            myCmd.CommandText = "insert into Table_ComparisionEntryRating (EntryID, CriteriaID, userid, vote, message, VoteDate) values('" & EntryID & "', '" & CriteriaID & "', '" & Val(Session("userid")) & "', '" & RatingEntryRate.CurrentRating & "', '" & Ratingmessage.Replace("'", "''") & "', '" & Now.ToString("yyyy-MM-ddTHH:mm:ss") & "')"
        Else
            myCmd.CommandText = "update Table_ComparisionEntryRating set Vote='" & RatingEntryRate.CurrentRating & "', message='" & Ratingmessage.Replace("'", "''") & "' where (userid='" & Val(Session("userid")) & "') and (EntryID='" & EntryID & "') and (CriteriaID='" & CriteriaID & "')"
        End If

        myReader = myCmd.ExecuteReader
        myReader.Close()
        myConn.Close()


    End Sub
</script>


<div class="form-group">
 
            <label class="control-label col-sm-4">
                <asp:Label ID="LabelCriteriaName" runat="server" Text=""></asp:Label>
                <asp:Label ID="LabelVoteCountShow" runat="server">(<asp:Label ID="LabelVoteCount" runat="server" Text="0"></asp:Label>)</asp:Label>:
                <asp:Label ID="LabelCriteriaID" runat="server" Text="0" Visible="False"></asp:Label>
                <asp:Label ID="LabelEntryID" runat="server" Text="0" Visible="False"></asp:Label>
            </label>
            <div class="col-sm-8">
                <ul class="list-inline"  >
                    <li>
                        <ajaxToolkit:Rating ID="RatingEntryRate" runat="server" MaxRating="10"
                            CurrentRating="2"
                            CssClass="form-control" Style="border: 0; box-shadow: none;"
                            StarCssClass="ratingStar"
                            WaitingStarCssClass="savedRatingStar"
                            FilledStarCssClass="filledRatingStar"
                            EmptyStarCssClass="emptyRatingStar" AutoPostBack="True" OnClick="RatingEntryRate_Click">
                        </ajaxToolkit:Rating>
                    </li>
                    <li runat="server" class="list-group-item" id="LiComment" style ="vertical-align :top; border: 0; box-shadow: none;"><a   data-toggle="collapse" href="#<%=Panelcomment.ClientID%>" ><i class="fa fa-pencil-square-o fa-lg fa-fw" aria-hidden="true"></i></a></li>
                </ul> 
    
               
                <asp:Panel runat="server" ID="Panelcomment" class="row collapse">
                    <div class="col-sm-12">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:TextBox ID="TextBoxMessage" runat="server" CssClass="form-control" paceholder="Your Coment" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                <asp:Button ID="ButtonSaveMessage" CssClass="btn btn-sm float-right" runat="server" Text="save" OnClick ="ButtonSaveMessage_Click" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </asp:Panel>
                
            </div>
       

</div>