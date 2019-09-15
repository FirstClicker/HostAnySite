<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Register Src="~/App_Controls/NavigationSideAccounts.ascx" TagPrefix="uc1" TagName="NavigationSideAccounts" %>

<script runat="server">
    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim Cusertype As FirstClickerService.Version1.User.UserType = FirstClickerService.Version1.User.ParseEnum_UserType(Trim(Session("UserType")))
        If Cusertype = FirstClickerService.Version1.User.UserType.Administrator Or Cusertype = FirstClickerService.Version1.User.UserType.Moderator Then
        Else
            Response.Redirect("~/user/signin.aspx?returnURL=" & "~" & Request.RawUrl)
        End If

        If IsPostBack = False Then
            loadAllAccountDetails()
            loadAllProduct()

            TextBoxDate.Text = Now.Date
        End If


    End Sub

    Private Function loadAllAccountDetails() As Boolean
        loadAllAccountDetails = True

        DropDownListDebitAc.Items.Clear()
        DropDownListCreditAc.Items.Clear()

        Dim ProductItem As New ListItem

        ProductItem.Text = "Select Product"
        ProductItem.Value = 0

        DropDownListDebitAc.Items.Add(ProductItem)
        DropDownListCreditAc.Items.Add(ProductItem)

        Dim myConn As SqlConnection
        Dim myCmd As SqlCommand
        Dim myReader As SqlDataReader

        myConn = New SqlConnection(WebAppSettings.DBCS)
        myCmd = myConn.CreateCommand
        myCmd.CommandText = "SELECT * FROM Table_acc_AccountDetails order by AccountName"
        myConn.Open()

        myReader = myCmd.ExecuteReader
        If myReader.HasRows = True Then
            Do While myReader.Read
                Dim ProductItem2 As New ListItem

                ProductItem2.Text = myReader.Item("AccountName")
                ProductItem2.Value = myReader.Item("AccountName")

                DropDownListDebitAc.Items.Add(ProductItem2)
                DropDownListCreditAc.Items.Add(ProductItem2)
            Loop
        End If
        myReader.Close()
        myConn.Close()
    End Function


    Private Function loadAllProduct() As Boolean
        loadAllProduct = True

        DropDownListProduct.Items.Clear()

        Dim ProductItem As New ListItem

        ProductItem.Text = "Select Product"
        ProductItem.Value = 0

        DropDownListProduct.Items.Add(ProductItem)

        Dim myConn As SqlConnection
        Dim myCmd As SqlCommand
        Dim myReader As SqlDataReader

        myConn = New SqlConnection(WebAppSettings.DBCS)
        myCmd = myConn.CreateCommand
        myCmd.CommandText = "SELECT * FROM Table_acc_ProductDetails order by Name"
        myConn.Open()

        myReader = myCmd.ExecuteReader
        If myReader.HasRows = True Then
            Do While myReader.Read
                Dim ProductItem2 As New ListItem

                ProductItem2.Text = myReader.Item("Name")
                ProductItem2.Value = myReader.Item("ProductId")

                DropDownListProduct.Items.Add(ProductItem2)
            Loop
        End If
        myReader.Close()
        myConn.Close()
    End Function


    Public Shared Function NewJournalID(dbcs As String) As Long
        NewJournalID = FirstClickerService.Common.GetRandomNumber(10000000, 99999999)

        Dim myConn As SqlConnection
        Dim myCmd As SqlCommand
        Dim myReader As SqlDataReader

        myConn = New SqlConnection(dbcs)
        myCmd = myConn.CreateCommand
        myCmd.CommandText = "SELECT * FROM Table_Acc_JournalBook where JournalID='" & NewJournalID & "'"

        myConn.Open()
        myReader = myCmd.ExecuteReader
        If myReader.HasRows = True Then
            NewJournalID = NewJournalID(dbcs)
        End If

        myReader.Close()
        myConn.Close()
    End Function


    Protected Sub ButtonSubmit_Click(sender As Object, e As EventArgs)
        Dim myConn As SqlConnection
        Dim myCmd As SqlCommand
        Dim myReader As SqlDataReader


        Dim mydatetime As DateTime = DateTime.Parse(TextBoxDate.Text)

        Dim heading As String = Trim(TextBoxTitle.Text)
        If Trim(heading) = "" Then
            heading = DropDownListDebitAc.SelectedItem.Text & " " & TextBoxWeight.Text & "kg " & DropDownListProduct.SelectedItem.Text
        End If

        myConn = New SqlConnection(WebAppSettings.DBCS)
        myCmd = myConn.CreateCommand
        myCmd.CommandText = "insert into Table_Acc_JournalBook (JournalID, EntryDate, Heading, amount, DebitAccount, CreditAccount, Sales_ProductID, Sales_Weight) values('" & NewJournalID(WebAppSettings.DBCS) & "', '" & mydatetime.ToString("yyyy-MM-ddTHH:mm:ss") & "','" & heading & "','" & TextBoxAmount.Text & "','" & DropDownListDebitAc.SelectedValue & "', '" & DropDownListCreditAc.SelectedValue & "', '" & DropDownListProduct.SelectedValue & "', '" & TextBoxWeight.Text & "')"
        myConn.Open()

        Try
            myReader = myCmd.ExecuteScalar
            myConn.Close()

            LabelEM.Text = "Submitted.."

            TextBoxTitle.Text = ""
            TextBoxAmount.Text = ""
            TextBoxWeight.Text = ""


        Catch ex As Exception
            LabelEM.Text = "Failed.. " & ex.Message
        End Try






    End Sub




    Protected Sub ButtonCheckDate_Click(sender As Object, e As EventArgs)
        Try
            Dim mydatetime As DateTime = DateTime.Parse(TextBoxDate.Text)
            ButtonCheckDate.Text = "Check (yyyy-MM-ddTHH:mm:ss): " & mydatetime.ToString("yyyy-MM-ddTHH:mm:ss")
        Catch ex As Exception

        End Try

    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row">
        <div class="col-12 col-sm-12 col-md-12 col-lg-3 col-xl-3">
            <uc1:NavigationSideAccounts runat="server" ID="NavigationSideAccounts" />
        </div>
        <div class="col-12 col-sm-12 col-md-12 col-lg-9 col-xl-9">
            <div class="card">
                <div class="card-header ">
                    Sales Entry
                </div>
                <div class="card-body ">
                    
                   

                      <div class="form-group">
                        <label for="pwd">Date (MM/dd/yyyy): <asp:Button ID="ButtonCheckDate" runat="server" OnClick ="ButtonCheckDate_Click"  Text="Check" />
                           </label>
                        &nbsp;<asp:TextBox ID="TextBoxDate" runat="server" cssclass="form-control" TextMode="Date" ></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label for="email">Debit A/c:</label>
                        <asp:DropDownList ID="DropDownListDebitAc" runat="server" CssClass="form-control" AutoPostBack="False" CausesValidation="True"></asp:DropDownList>
                    </div>


                    
                    <div class="form-group">
                        <label for="email">Credit A/c:</label>
                        <asp:DropDownList ID="DropDownListCreditAc" runat="server" CssClass="form-control" AutoPostBack="False" CausesValidation="True"></asp:DropDownList>
                    </div>




                       <div class="form-group">
                        <label for="email">Product:</label>
                        <asp:DropDownList ID="DropDownListProduct" runat="server" CssClass="form-control" AutoPostBack="False" CausesValidation="True"></asp:DropDownList>
                    </div>

                     <div class="form-group">
                        <label for="pwd">Weight:</label>
                        <asp:TextBox ID="TextBoxWeight" runat="server" cssclass="form-control"  ></asp:TextBox>
                    </div>




                     <div class="form-group">
                        <label for="email">Amount :</label>
                        <asp:TextBox ID="TextBoxAmount" CssClass ="form-control" runat="server"></asp:TextBox>
                    </div>


                     <div class="form-group">
                        <label for="email">Heading :</label>
                        <asp:TextBox ID="TextBoxTitle" CssClass ="form-control" runat="server"></asp:TextBox>
                    </div>



                     <div class="form-group">
                         <asp:Label ID="LabelEM" runat="server" Text="" ></asp:Label>
                    </div>


                        <div class="form-group clearfix ">
                        <div class="float-left ">
                            <div class="checkbox">
                                <label>
                                    <asp:CheckBox ID="CheckBoxCashSale" runat="server" />
                                    Cash Sale</label>
                            </div>
                        </div>
                        <div class="float-right ">
                            <asp:Button ID="ButtonSubmit" runat="server" CssClass="btn btn-sm btn-primary" Text="Submit" OnClick="ButtonSubmit_Click"  />
                        </div>
                    </div>


                </div>
            </div>
        </div>
    </div> 
</asp:Content>

