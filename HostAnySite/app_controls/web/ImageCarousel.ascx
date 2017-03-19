<%@ Control Language="VB" ClassName="ImageCarousel" %>

<script runat="server">
    
    Public Property Carousel_WebSetting() As String
        Get
            Return LabelWebSettingName.Text
        End Get
        Set(ByVal value As String)
            LabelWebSettingName.Text = value
        End Set
    End Property
    
    
    
    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim websetting As ClassHostAnySite.WebSetting.StructureWebSetting
        websetting = ClassHostAnySite.WebSetting.WebSetting_Get(Carousel_WebSetting & "1", ClassAppDetails.DBCS)
        DivCarouselImage1.Visible = CBool(Len(Trim(websetting.SettingValue)))
        CarouselImage1.ImageUrl = "~/Content/image/" & websetting.SettingValue
        
        websetting = ClassHostAnySite.WebSetting.WebSetting_Get(Carousel_WebSetting & "2", ClassAppDetails.DBCS)
        If DivCarouselImage1.Visible = False Then
            DivCarouselImage1.Visible = CBool(Len(Trim(websetting.SettingValue)))
            CarouselImage1.ImageUrl = "~/Content/image/" & websetting.SettingValue
        Else
            DivCarouselImage2.Visible = CBool(Len(Trim(websetting.SettingValue)))
            CarouselImage2.ImageUrl = "~/Content/image/" & websetting.SettingValue
        End If
      
        
        websetting = ClassHostAnySite.WebSetting.WebSetting_Get(Carousel_WebSetting & "3", ClassAppDetails.DBCS)
        If DivCarouselImage1.Visible = False Then
            DivCarouselImage1.Visible = CBool(Len(Trim(websetting.SettingValue)))
            CarouselImage1.ImageUrl = "~/Content/image/" & websetting.SettingValue
            
            homeslide.Visible = CBool(Len(Trim(websetting.SettingValue)))
        Else
            If DivCarouselImage2.Visible = False Then
                DivCarouselImage2.Visible = CBool(Len(Trim(websetting.SettingValue)))
                CarouselImage2.ImageUrl = "~/Content/image/" & websetting.SettingValue
            Else
                DivCarouselImage3.Visible = CBool(Len(Trim(websetting.SettingValue)))
                CarouselImage3.ImageUrl = "~/Content/image/" & websetting.SettingValue
            End If
        End If
     
    End Sub
</script>
<div runat="server" id="homeslide" class="row carousel-holder">
    <asp:Label ID="LabelWebSettingName" runat="server" Text="" Visible="False"></asp:Label>
    <div class="col-md-12">
        <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
            <!-- <ol class="carousel-indicators">
                            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                           
                                <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                                <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                               
                        </ol> -->
            <div class="carousel-inner">
                <div runat="server" id="DivCarouselImage1" class="item active" visible="False">
                    <asp:Image runat="server" ID="CarouselImage1" class="slide-image img-rounded " />
                </div>

                <div runat="server" id="DivCarouselImage2" class="item" visible="False">
                    <asp:Image runat="server" ID="CarouselImage2" class="slide-image img-rounded " />
                </div>
                <div runat="server" id="DivCarouselImage3" class="item" visible="False">
                    <asp:Image runat="server" ID="CarouselImage3" class="slide-image img-rounded " />
                </div>
                <!--       -->
            </div>
            <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-left"></span>
            </a>
            <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right"></span>
            </a>
        </div>
    </div>

</div>

