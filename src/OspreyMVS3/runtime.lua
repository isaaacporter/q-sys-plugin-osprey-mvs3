------------------------------------
-- Constants
------------------------------------
local PacketHeader = "\xA5\x6C"
local PacketEnd = "\xAE"
local MinimumPacketLength = 20
local DeviceTypeMVS3 = "\xA3"
local InterfaceTypeUart = "\x00"
local InterfaceTypeLan = "\x01"
local CommandReadAllData = "\x90"
local CommandRenameDevice = "\x91"
local CommandBorderEnable = "\xA4"
local CommandBorderColor = "\x93"
local CommandOutputLayout = "\x94"
local CommandOutputResolution = "\x92"
local CommandUmdOverlayEnable = "\x95"
local CommandUmdPosition = "\x96"
local CommandUmdTextColor = "\x97"
local CommandUmdBackgroundColor = "\x98"
local CommandUmdText = "\x99"
local CommandAudioMeterEnable = "\x9A"
local CommandAudioMeterPosition = "\x9B"
local CommandAudioSource = "\x9E"
local CommandOsdEnable = "\x9F"
local CommandOsdTextColor = "\xA0"
local CommandOsdBackgroundColor = "\xA1"
local CommandOsdPosition = "\xA2"
local CommandSaveCustom = "\xA3"
local CommandCharacterSize = "\xA5"
local CommandReset = "\xA6"
local SizeSmall = "\x00"
local SizeMedium = "\x01"
local SizeLarge = "\x02"
local PositionLeft = "\x00"
local PositionCenter = "\x01"
local PositionRight = "\x02"
local On = "\x01"
local Off = "\x00"
local DeviceId = "\xFF"
local ReservedBytes = "\x00\x00\x00\x00\x00\x00\x00\x00\x00"
local SocketIsOpen = false

------------------------------------
-- Socket Handling
------------------------------------
socket = UdpSocket.New()

socket.EventHandler = function(udp, packet)
  print(packet.Address, packet.Port, packet.Data)
end

function CloseSocket()
  print("Closing UDP Socket")
  socket:Close()
  SocketIsOpen = false
end

function OpenSocket()
  print("Opening UDP Socket at: "..Properties["IP Address"].Value..":"..Properties["Port"].Value)
  socket:Open(Properties["IP Address"].Value, Properties["Port"].Value)
  SocketIsOpen = true
end

function Send(command, packetData)
    local fullCommand = PacketHeader..PacketLength(packetData)..DeviceTypeMVS3..DeviceId..InterfaceTypeLan..ReservedBytes..command..packetData
    fullCommand = fullCommand..Checksum2ByteModulo256(fullCommand)..PacketEnd
    print(PrettyPrintHex(fullCommand))
    if not SocketIsOpen then
      OpenSocket()
    end
    print(PrettyPrintHex(command))
    socket:Send(Properties["IP Address"].Value, Properties["Port"].Value, command)
end

------------------------------------
-- Helper Functions
------------------------------------
function Checksum2ByteModulo256(packet)
  local checksum = 0
  -- Iterate over the bytes in the packet
  for i = 1, #packet do
    checksum = checksum + packet:byte(i)
  end
  -- Extract the lower byte and upper byte
  local lowerByte = checksum & 255
  local upperByte = (checksum >> 8) & 255

  return string.char(lowerByte, upperByte)
end

function PrettyPrintHex(cmd)
  local visual = ""
  for i=1,#cmd do
    local byte = cmd:sub(i,i)
    if string.byte(byte) >= 32 and string.byte(byte) <= 126 then
      visual = visual..string.format("[0x%02X]",string.byte(byte))
    else
      visual = visual..string.format("[0x%02X]",string.byte(byte))
    end
  end
  return visual
end
 
function PacketLength(packetData)
  local length = #packetData + 20
  local lengthByte1 = string.char(length % 256)
  local lengthByte2 = string.char(math.floor(length / 256))
  return lengthByte1..lengthByte2
end
 
function FormatAndSendText(text, window)
    local ba = {string.char(window - 1)}
    local textBytes = ConvertStringToByteArray(text)
    
    for i = 1, #textBytes do
      table.insert(ba, string.char(textBytes[i]))
      table.insert(ba, "\x00")
    end
    
    local baString = table.concat(ba)        
    return baString
  end

function ConvertStringToByteArray(str)
  local byteArray = {}
  for i = 1, #str do
    table.insert(byteArray, string.byte(str, i))
  end
  return byteArray
end
 
------------------------------------
-- Controls
------------------------------------
------------------------------------
-- Scaling/Output
------------------------------------
local OutputFormatChoices = {"1080p60", "1080p50", "1080p30", "1080p25", "1080p24", "1080i60", "1080i50", "720p60", "720p50", "720p30", "720p25"}
Controls["output_format"].Choices = OutputFormatChoices
Controls["output_format"].EventHandler = function(ctl)
  for idx, val in ipairs(OutputFormatChoices) do
    if ctl.String == val then
      Send(CommandOutputResolution, string.char(idx - 1))
    end
  end
end

local BorderEnableChoices = {"Border OFF", "Border ON"}
Controls["border_enable"].Choices = BorderEnableChoices
Controls["border_enable"].EventHandler = function(ctl)
  for idx, val in ipairs(BorderEnableChoices) do
    if ctl.String == val then
      Send(CommandBorderEnable, string.char(idx - 1))
    end
  end
end

local BorderColorChoices = {"White", "Red", "Green", "Blue"}
Controls["border_color"].Choices = BorderColorChoices
Controls["border_color"].EventHandler = function(ctl)
  for idx, val in ipairs(BorderColorChoices) do
    if ctl.String == val then
      Send(CommandBorderColor, string.char(idx - 1))
    end
  end
end

for idx = 1, 16 do
  Controls["layout_"..idx.."_recall"].EventHandler = function(ctl)
    if ctl.Boolean then
      Send(CommandOutputLayout, string.char(idx - 1))
      LayoutFeedback(idx)
    else
      ctl.Boolean = true
    end
  end
end

function LayoutFeedback(intIndex)
  for idx = 1, 16 do
    Controls["layout_"..idx.."_recall"].Boolean = intIndex==idx
  end
end

------------------------------------
-- Window Controls
------------------------------------
local UmdEnableChoices = {"OFF", "ON"}
local UmdPositionChoices = {"Left", "Middle", "Right"}
local UmdTextColorChoices = {"Black", "Blue", "Red", "Magenta", "Green", "Cyan", "Yellow", "White", "Gray", "VioletRed", "LightBlue", "LightGreen", "LightCyan", "LightYellow", "Trans", "HalfTrans"}
local UmdBackgroundColorChoices = {"Black", "Blue", "Red", "Magenta", "Green", "Cyan", "Yellow", "White", "Gray", "VioletRed", "LightBlue", "LightGreen", "LightCyan", "LightYellow", "Trans", "HalfTrans"}
local AudioMeterEnableChoices = {"OFF", "ON"}
local AudioMeterPositionChoices = {"Left", "Right"}
local AudioMeterChannelChoices = {"CH1-2", "CH3-4", "CH5-6", "CH7-8", "CH9-10", "CH11-12", "CH13-14", "CH15-16"}
local OsdEnableChoices = {"OFF", "ON"}
local OsdPositionChoices = {"Left", "Middle", "Right"}
local OsdTextColorChoices = {"Black", "Blue", "Red", "Magenta", "Green", "Cyan", "Yellow", "White", "Gray", "VioletRed", "LightBlue", "LightGreen", "LightCyan", "LightYellow", "Trans", "HalfTrans"}
local OsdBackgroundColorChoices = {"Black", "Blue", "Red", "Magenta", "Green", "Cyan", "Yellow", "White", "Gray", "VioletRed", "LightBlue", "LightGreen", "LightCyan", "LightYellow", "Trans", "HalfTrans"}

for i = 1, 4 do
  Controls["window_"..i.."_umd_enable"].Choices = UmdEnableChoices
  Controls["window_"..i.."_umd_enable"].EventHandler = function(ctl)
    for idx, val in ipairs(UmdEnableChoices) do
      if ctl.String == val then
        Send(CommandUmdOverlayEnable, string.char(i - 1)..string.char(idx - 1))
      end
    end
  end

  Controls["window_"..i.."_umd_position"].Choices = UmdPositionChoices
  Controls["window_"..i.."_umd_position"].EventHandler = function(ctl)
    for idx, val in ipairs(UmdPositionChoices) do
      if ctl.String == val then
        Send(CommandUmdPosition, string.char(i - 1)..string.char(idx - 1))
      end
    end
  end

  Controls["window_"..i.."_umd_text_color"].Choices = UmdTextColorChoices
  Controls["window_"..i.."_umd_text_color"].EventHandler = function(ctl)
    for idx, val in ipairs(UmdTextColorChoices) do
      if ctl.String == val then
        Send(CommandUmdTextColor, string.char(i - 1)..string.char(idx - 1))
      end
    end
  end

  Controls["window_"..i.."_umd_background_color"].Choices = UmdBackgroundColorChoices
  Controls["window_"..i.."_umd_background_color"].EventHandler = function(ctl)
    for idx, val in ipairs(UmdBackgroundColorChoices) do
      if ctl.String == val then
        Send(CommandUmdBackgroundColor, string.char(i - 1)..string.char(idx - 1))
      end
    end
  end

  Controls["window_"..i.."_umd_text"].EventHandler = function(ctl)
    Send(CommandUmdText, FormatAndSendText(ctl.String, i))
  end

  Controls["window_"..i.."_audiometer_enable"].Choices = AudioMeterEnableChoices
  Controls["window_"..i.."_audiometer_enable"].EventHandler = function(ctl)
    for idx, val in ipairs(AudioMeterEnableChoices) do
      if ctl.String == val then
        Send(CommandAudioMeterEnable, string.char(i - 1)..string.char(idx - 1))
      end
    end
  end

  Controls["window_"..i.."_audiometer_position"].Choices = AudioMeterPositionChoices
  Controls["window_"..i.."_audiometer_position"].EventHandler = function(ctl)
    for idx, val in ipairs(AudioMeterPositionChoices) do
      if ctl.String == val then
        Send(CommandAudioMeterPosition, string.char(i - 1)..string.char(idx - 1))
      end
    end
  end

  Controls["window_"..i.."_audiometer_channel"].Choices = AudioMeterChannelChoices
  Controls["window_"..i.."_audiometer_channel"].EventHandler = function(ctl)
    for idx, val in ipairs(AudioMeterChannelChoices) do
      if ctl.String == val then
        Send(CommandAudioSource, string.char(i - 1)..string.char(idx - 1))
      end
    end
  end

  Controls["window_"..i.."_osd_enable"].Choices = OsdEnableChoices
  Controls["window_"..i.."_osd_enable"].EventHandler = function(ctl)
    for idx, val in ipairs(OsdEnableChoices) do
      if ctl.String == val then
        Send(CommandOsdEnable, string.char(i - 1)..string.char(idx - 1))
      end
    end
  end

  Controls["window_"..i.."_osd_position"].Choices = OsdPositionChoices
  Controls["window_"..i.."_osd_position"].EventHandler = function(ctl)
    for idx, val in ipairs(OsdPositionChoices) do
      if ctl.String == val then
        Send(CommandOsdPosition, string.char(i - 1)..string.char(idx - 1))
      end
    end
  end

  Controls["window_"..i.."_osd_text_color"].Choices = OsdTextColorChoices
  Controls["window_"..i.."_osd_text_color"].EventHandler = function(ctl)
    for idx, val in ipairs(OsdTextColorChoices) do
      if ctl.String == val then
        Send(CommandOsdTextColor, string.char(i - 1)..string.char(idx - 1))
      end
    end
  end

  Controls["window_"..i.."_osd_background_color"].Choices = OsdBackgroundColorChoices
  Controls["window_"..i.."_osd_background_color"].EventHandler = function(ctl)
    for idx, val in ipairs(OsdBackgroundColorChoices) do
      if ctl.String == val then
        Send(CommandOsdBackgroundColor, string.char(i - 1)..string.char(idx - 1))
      end
    end
  end
end

--1-Judge - \xA5\x6C\x1F\x00\xA3\xFF\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x99\x00\x4A\x00\x75\x00\x64\x00\x67\x00\x65\x00\x5B\x05\xAE 
--2-Witness - \xA5\x6C\x23\x00\xA3\xFF\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x99\x01\x57\x00\x69\x00\x74\x00\x6E\x00\x65\x00\x73\x00\x73\x00\x5E\x06\xAE 
--3-Table 1 - \xA5\x6C\x23\x00\xA3\xFF\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x99\x02\x54\x00\x61\x00\x62\x00\x6C\x00\x65\x00\x20\x00\x31\x00\xAB\x05\xAE 
--4-Table 2 - \xA5\x6C\x23\x00\xA3\xFF\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x99\x03\x54\x00\x61\x00\x62\x00\x6C\x00\x65\x00\x20\x00\x32\x00\xAD\x05\xAE 
--3-Defense  - \xA5\x6C\x23\x00\xA3\xFF\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x99\x02\x44\x00\x65\x00\x66\x00\x65\x00\x6e\x00\x73\x00\x65\x00\x2C\x06\xAE 
--4-Prosecution - \xA5\x6C\x2B\x00\xA3\xFF\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x99\x03\x50\x00\x72\x00\x6F\x00\x73\x00\x65\x00\x63\x00\x75\x00\x74\x00\x69\x00\x6F\x00\x6E\x00\x16\x08\xAE 
 
--Meter Off: 
--\xA5\x6C\x16\x00\xA3\xFF\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x9A\x00\x00\x64\x03\xAE 
--\xA5\x6C\x16\x00\xA3\xFF\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x9A\x03\x01\x65\x03\xAE 
--\xA5\x6C\x16\x00\xA3\xFF\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x9A\x03\x02\x66\x03\xAE 
--\xA5\x6C\x16\x00\xA3\xFF\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x9A\x03\x03\x67\x03\xAE 
 
--Resolution Off: 
--\xA5\x6C\x16\x00\xA3\xFF\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x9F\x00\x00\x69\x03\xAE 
--\xA5\x6C\x16\x00\xA3\xFF\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x9F\x01\x00\x6A\x03\xAE 
--\xA5\x6C\x16\x00\xA3\xFF\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x9F\x02\x00\x6B\x03\xAE 
--\xA5\x6C\x16\x00\xA3\xFF\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x9F\x03\x00\x6C\x03\xAE 
 
--Label Off: 
--\xA5\x6C\x16\x00\xA3\xFF\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x95\x00\x00\x5F\x03\xAE
--\xA5\x6C\x16\x00\xA3\xFF\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x95\x01\x00\x60\x03\xAE 
--\xA5\x6C\x16\x00\xA3\xFF\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x95\x02\x00\x61\x03\xAE 
--\xA5\x6C\x16\x00\xA3\xFF\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x95\x03\x00\x62\x03\xAE 