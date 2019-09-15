Imports System.Diagnostics
Imports System.Runtime.Serialization
Imports Hammock.Model
Imports Newtonsoft.Json



<Serializable> _
<DataContract> _
<DebuggerDisplay("{ScreenName}")> _
<JsonObject(MemberSerialization.OptIn)> _
Public Class ClassTwitterUser
    Inherits PropertyChangedBase

    Public _description As String
    Public _followersCount As Integer
    Public _id As Long
    Public _isProtected As System.Nullable(Of Boolean)
    Public _location As String
    Public _name As String
    Public _Email As String
    Public _profileImageUrl As String
    Public _screenName As String
    '   Public _status As TwitterStatus
    Public _url As String
    '  Private _createdDate As DateTime
    Public _isVerified As System.Nullable(Of Boolean)
    Public _isGeoEnabled As System.Nullable(Of Boolean)
    Public _isProfileBackgroundTiled As Boolean
    Public _profileBackgroundColor As String
    Public _profileBackgroundImageUrl As String
    Public _profilebannerurl As String
    Public _profileLinkColor As String
    Public _profileSidebarBorderColor As String
    Public _profileSidebarFillColor As String
    Public _profileTextColor As String
    Public _statusesCount As Integer
    Public _friendsCount As Integer
    Public _favouritesCount As Integer
    Public _listedCount As Integer
    Public _timeZone As String
    Public _utcOffset As String
    Public _language As String
    Public _followRequestSent As System.Nullable(Of Boolean)
    Public _isTranslator As System.Nullable(Of Boolean)
    Public _contributorsEnabled As System.Nullable(Of Boolean)
    Public _defaultProfile As System.Nullable(Of Boolean)
    Public _profileBackgroundImageUrlHttps As String
    Public _profileImageUrlHttps As String
    Public _followingBack As Boolean

    Public Overridable Property Id() As Long
        Get
            Return _id
        End Get
        Set(value As Long)
            If _id = value Then
                Return
            End If

            _id = value
            OnPropertyChanged("Id")
        End Set
    End Property



    <JsonProperty("followers_count")> _
    <DataMember> _
    Public Overridable Property FollowersCount() As Integer
        Get
            Return _followersCount
        End Get
        Set(value As Integer)
            If _followersCount = value Then
                Return
            End If

            _followersCount = value
            OnPropertyChanged("FollowersCount")
        End Set
    End Property



    <DataMember> _
    Public Overridable Property Name() As String
        Get
            Return _name
        End Get
        Set(value As String)
            If _name = value Then
                Return
            End If

            _name = value
            OnPropertyChanged("Name")
        End Set
    End Property


    <DataMember> _
    Public Overridable Property Email() As String
        Get
            Return _email
        End Get
        Set(value As String)
            If _name = value Then
                Return
            End If

            _email = value
            OnPropertyChanged("Email")
        End Set
    End Property

    <DataMember> _
    Public Overridable Property Description() As String
        Get
            Return _description
        End Get
        Set(value As String)
            If _description = value Then
                Return
            End If

            _description = value
            OnPropertyChanged("Description")
        End Set
    End Property



    <JsonProperty("profile_image_url")> _
    <DataMember> _
    Public Overridable Property ProfileImageUrl() As String
        Get
            Return _profileImageUrl
        End Get
        Set(value As String)
            If _profileImageUrl = value Then
                Return
            End If

            _profileImageUrl = value
        End Set
    End Property



    <DataMember> _
    Public Overridable Property Url() As String
        Get
            Return _url
        End Get
        Set(value As String)
            If _url = value Then
                Return
            End If

            _url = value
            OnPropertyChanged("Url")
        End Set
    End Property



    <JsonProperty("protected")> _
    <DataMember> _
    Public Overridable Property IsProtected() As System.Nullable(Of Boolean)
        Get
            Return _isProtected
        End Get
        Set(value As System.Nullable(Of Boolean))
            If _isProtected = value Then
                Return
            End If

            _isProtected = value
            OnPropertyChanged("IsProtected")
        End Set
    End Property



    <JsonProperty("Screen_Name")> _
    <DataMember> _
    Public Overridable Property ScreenName() As String
        Get
            Return _screenName
        End Get
        Set(value As String)
            If _screenName = value Then
                Return
            End If

            _screenName = value
            OnPropertyChanged("ScreenName")
        End Set
    End Property




    <DataMember> _
    Public Overridable Property Location() As String
        Get
            Return _location
        End Get
        Set(value As String)
            If _location = value Then
                Return
            End If

            _location = value
            OnPropertyChanged("Location")
        End Set
    End Property




    '  <DataMember> _
    '  Public Overridable Property Status() As TwitterStatus
    '     Get
    '         Return _status
    '     End Get
    '     Set(value As TwitterStatus)
    '         If _status = value Then
    '             Return
    '         End If
    '
    '        _status = value
    '        OnPropertyChanged("Status")
    '    End Set
    'End Property



    <JsonProperty("friends_count")> _
    <DataMember> _
    Public Overridable Property FriendsCount() As Integer
        Get
            Return _friendsCount
        End Get
        Set(value As Integer)
            If _friendsCount = value Then
                Return
            End If

            _friendsCount = value
            OnPropertyChanged("FriendsCount")
        End Set
    End Property




    <DataMember> _
    Public Overridable Property ProfileBackgroundColor() As String
        Get
            Return _profileBackgroundColor
        End Get
        Set(value As String)
            If _profileBackgroundColor = value Then
                Return
            End If

            _profileBackgroundColor = value
            OnPropertyChanged("ProfileBackgroundColor")
        End Set
    End Property




    <DataMember> _
    Public Overridable Property UtcOffset() As String
        Get
            Return _utcOffset
        End Get
        Set(value As String)
            If _utcOffset = value Then
                Return
            End If

            _utcOffset = value
            OnPropertyChanged("UtcOffset")
        End Set
    End Property




    <DataMember> _
    Public Overridable Property ProfileTextColor() As String
        Get
            Return _profileTextColor
        End Get
        Set(value As String)
            If _profileTextColor = value Then
                Return
            End If

            _profileTextColor = value
            OnPropertyChanged("ProfileTextColor")
        End Set
    End Property



    <JsonProperty("profile_background_image_url")> _
    <DataMember> _
    Public Overridable Property ProfileBackgroundImageUrl() As String
        Get
            Return _profileBackgroundImageUrl
        End Get
        Set(value As String)
            If _profileBackgroundImageUrl = value Then
                Return
            End If

            _profileBackgroundImageUrl = value
            OnPropertyChanged("ProfileBackgroundImageUrl")
        End Set
    End Property



    <JsonProperty("profile_banner_url")> _
   <DataMember> _
    Public Overridable Property profilebannerurl() As String
        Get
            Return _profilebannerurl
        End Get
        Set(value As String)
            If _profilebannerurl = value Then
                Return
            End If

            _profilebannerurl = value
            OnPropertyChanged("profilebannerurl")
        End Set
    End Property


    <DataMember> _
    Public Overridable Property TimeZone() As String
        Get
            Return _timeZone
        End Get
        Set(value As String)
            If _timeZone = value Then
                Return
            End If

            _timeZone = value
            OnPropertyChanged("TimeZone")
        End Set
    End Property



    <DataMember> _
    Public Overridable Property FavouritesCount() As Integer
        Get
            Return _favouritesCount
        End Get
        Set(value As Integer)
            If _favouritesCount = value Then
                Return
            End If

            _favouritesCount = value
            OnPropertyChanged("FavouritesCount")
        End Set
    End Property



    <DataMember> _
    Public Overridable Property ListedCount() As Integer
        Get
            Return _listedCount
        End Get
        Set(value As Integer)
            If _listedCount = value Then
                Return
            End If

            _listedCount = value
            OnPropertyChanged("ListedCount")
        End Set
    End Property



    <DataMember> _
    Public Overridable Property ProfileLinkColor() As String
        Get
            Return _profileLinkColor
        End Get
        Set(value As String)
            If _profileLinkColor = value Then
                Return
            End If

            _profileLinkColor = value
            OnPropertyChanged("ProfileLinkColor")
        End Set
    End Property



    <DataMember> _
    Public Overridable Property StatusesCount() As Integer
        Get
            Return _statusesCount
        End Get
        Set(value As Integer)
            If _statusesCount = value Then
                Return
            End If

            _statusesCount = value
            OnPropertyChanged("StatusesCount")
        End Set
    End Property


    <DataMember> _
    Public Overridable Property ProfileSidebarFillColor() As String
        Get
            Return _profileSidebarFillColor
        End Get
        Set(value As String)
            If _profileSidebarFillColor = value Then
                Return
            End If

            _profileSidebarFillColor = value
            OnPropertyChanged("ProfileSidebarFillColor")
        End Set
    End Property


    <DataMember> _
    Public Overridable Property ProfileSidebarBorderColor() As String
        Get
            Return _profileSidebarBorderColor
        End Get
        Set(value As String)
            If _profileSidebarBorderColor = value Then
                Return
            End If

            _profileSidebarBorderColor = value
            OnPropertyChanged("ProfileSidebarBorderColor")
        End Set
    End Property



    <JsonProperty("profile_background_tile")> _
    <DataMember> _
    Public Overridable Property IsProfileBackgroundTiled() As Boolean
        Get
            Return _isProfileBackgroundTiled
        End Get
        Set(value As Boolean)
            If _isProfileBackgroundTiled = value Then
                Return
            End If

            _isProfileBackgroundTiled = value
            OnPropertyChanged("IsProfileBackgroundTiled")
        End Set
    End Property



    <JsonProperty("verified")> _
    <DataMember> _
    Public Overridable Property IsVerified() As System.Nullable(Of Boolean)
        Get
            Return _isVerified
        End Get
        Set(value As System.Nullable(Of Boolean))
            If _isVerified = value Then
                Return
            End If

            _isVerified = value
            OnPropertyChanged("IsVerified")
        End Set
    End Property



    <JsonProperty("geo_enabled")> _
    <DataMember> _
    Public Overridable Property IsGeoEnabled() As System.Nullable(Of Boolean)
        Get
            Return _isGeoEnabled
        End Get
        Set(value As System.Nullable(Of Boolean))
            If _isGeoEnabled = value Then
                Return
            End If

            _isGeoEnabled = value
            OnPropertyChanged("IsGeoEnabled")
        End Set
    End Property



    <JsonProperty("lang")> _
    <DataMember> _
    Public Overridable Property Language() As String
        Get
            Return _language
        End Get
        Set(value As String)
            If _language = value Then
                Return
            End If
            _language = value
            OnPropertyChanged("Language")
        End Set
    End Property



    ' <JsonProperty("created_at")> _
    '<DataMember> _
    'Public Overridable Property CreatedDate() As DateTime
    '   Get
    '      Return _createdDate
    ' End Get
    '  Set(value As DateTime)
    '     If _createdDate = value Then
    '        Return
    '    End If

    '        _createdDate = value
    '       OnPropertyChanged("CreatedDate")
    '  End Set
    'End Property



    <DataMember> _
    Public Overridable Property FollowRequestSent() As System.Nullable(Of Boolean)
        Get
            Return _followRequestSent
        End Get
        Set(value As System.Nullable(Of Boolean))
            If _followRequestSent = value Then
                Return
            End If

            _followRequestSent = value
            OnPropertyChanged("FollowRequestSent")
        End Set
    End Property

    <DataMember> _
    Public Overridable Property Following() As System.Nullable(Of Boolean)
        Get
            Return _followingBack
        End Get
        Set(value As System.Nullable(Of Boolean))
            If _followingBack = value Then
                Return
            End If

            _followingBack = value
            OnPropertyChanged("FollowRequestSent")
        End Set
    End Property

    <DataMember> _
    Public Overridable Property IsTranslator() As System.Nullable(Of Boolean)
        Get
            Return _isTranslator
        End Get
        Set(value As System.Nullable(Of Boolean))
            If _isTranslator = value Then
                Return
            End If

            _isTranslator = value
            OnPropertyChanged("IsTranslator")
        End Set
    End Property



    <DataMember> _
    Public Overridable Property ContributorsEnabled() As System.Nullable(Of Boolean)
        Get
            Return _contributorsEnabled
        End Get
        Set(value As System.Nullable(Of Boolean))
            If _contributorsEnabled = value Then
                Return
            End If

            _contributorsEnabled = value
            OnPropertyChanged("ContributorsEnabled")
        End Set
    End Property



    <DataMember> _
    Public Overridable Property ProfileBackgroundImageUrlHttps() As String
        Get
            Return _profileBackgroundImageUrlHttps
        End Get
        Set(value As String)
            If _profileBackgroundImageUrlHttps = value Then
                Return
            End If

            _profileBackgroundImageUrlHttps = value
            OnPropertyChanged("ProfileBackgroundImageUrlHttps")
        End Set
    End Property



    <DataMember> _
    Public Overridable Property ProfileImageUrlHttps() As String
        Get
            Return _profileImageUrlHttps
        End Get
        Set(value As String)
            If _profileImageUrlHttps = value Then
                Return
            End If

            _profileImageUrlHttps = value
            OnPropertyChanged("ProfileImageUrlHttps")
        End Set
    End Property



    <DataMember> _
    <JsonProperty("default_profile")> _
    Public Overridable Property IsDefaultProfile() As System.Nullable(Of Boolean)
        Get
            Return _defaultProfile
        End Get
        Set(value As System.Nullable(Of Boolean))
            If _defaultProfile = value Then
                Return
            End If

            _defaultProfile = value
            OnPropertyChanged("IsDefaultProfile")
        End Set
    End Property



    <DataMember> _
    Public Overridable Property RawSource() As String
        Get
            Return m_RawSource
        End Get
        Set(value As String)
            m_RawSource = value
        End Set
    End Property
    Private m_RawSource As String


End Class
