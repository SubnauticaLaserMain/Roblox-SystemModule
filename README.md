This ModuleScript has functions u can call, and help u make a game better, i will try to main-tain this Module to always work for the Latest Version of roblox, medout changing any names, so u can always use it


NOTE: SOME FUNCTIONS WORKS FOR BOTH Client AND Server SIDE SCRIPTS





## Functions:



SystemPlayerService

SystemChatService

SystemReplicatedStorage

SystemConverterService






## SystemPlayerService:


**getBackpack** - Returns the Backpack from the Player. Client AND Server

**getStarterGear** - Returns the StarterGear from the Player. Client AND Server

**getPlayerScripts** - Returns PlayerScripts from the Player. Client AND Server






## SystemChatService:


**SendMessageInChat** - Contains functions to send Message's in Chat. NOT FROM PLAYER. Client AND Server

**IsChatOnLatestVersion** - Returns FALSE if Chat is on LEGACYCHATSERVICE. Client AND Server





### SendMessageInChat:



**SendMessage** - Sends a Message in Chat. Client AND Server

**SendMessageWithFont** - You can send a Message in chat with. Color, Font and MORE. Client AND Server | Args: *Text: string, Color: Color3, FontEnum: Enum.Font, FontSize: number | string*




## SystemConverterService


**TextToBase64** - Converts your Text to Base64

**Base64ToText** - Converts your Base64 to Text

**TextToHex** - Converts your Text to Hex

**HexToText** - Converts your Hex to Text

**TextToBinary** - Converts your Text to Binary

**BinaryToText** - Converts your Binary to Text

**TextToDecimal** - Converts your Text to Decimal

**DecimalToText** - Converts your Decimal to Text







## How to Allow Scripts?

You mith have noticed this when u tried to call a function inside the **SystemModule**
<p align="center">
   <img src="J232U.PNG">
</p>

### How to Fix

Go to this line in the Code
<p align="center">
   <img src="HowTo.PNG">
</p>
then do it like this:

**local AllowedScripts = {{
	['path'] = 'ReplicatedFirst.System',
	['Is'] = 'LocalScript'
}, {
   ['path'] = 'path',
   ['Is'] = 'TypeOf'
}}**

**U CAN ADD AS MANY AS U WANT, JUST REMEMBER TO MAKE IT LIKE THE EXSAMPLE I MADE IN THE CODE, AND U SHOULD BE FINE**
