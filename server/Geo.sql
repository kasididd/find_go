SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+07:00";

CREATE Database Geo;

CREATE TABLE `Admin_Target` (
  `AT_ID` int(11) NOT NULL,
  `U_ID` int(11) DEFAULT NULL,
  `Target_U_ID` int(11) DEFAULT NULL,
  `U_Class` set('1','2','3') DEFAULT NULL,
  `StartTime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `EndTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Block` int(11) DEFAULT NULL,
  `Alert` text DEFAULT NULL,
  `Time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
CREATE TABLE `CateLink` (
  `CA_ID` int(11) NOT NULL,
  `R_ID` int(11) DEFAULT NULL,
  `CA_Owner` int(11) DEFAULT NULL,
  `CA_Name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `Chat` (
  `C_ID` int(11) NOT NULL,
  `Sender` int(11) DEFAULT NULL,
  `Receiver` int(11) DEFAULT NULL,
  `Text` text DEFAULT NULL,
  `Time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `Link` (
  `L_ID` int(11) NOT NULL,
  `CA_ID` int(11) DEFAULT NULL,
  `Owner` int(11) DEFAULT NULL,
  `Link` varchar(255) DEFAULT NULL,
  `L_Icons` varchar(255) DEFAULT NULL,
  `Time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `PinMaps` (
  `Pin_ID` int(11) NOT NULL,
  `Pin_Name` varchar(100) DEFAULT NULL,
  `Pin_Location` varchar(255) DEFAULT NULL,
  `Pin_Detail` text DEFAULT NULL,
  `Pin_Tell` int(10) DEFAULT NULL,
  `Pin_Link` varchar(255) DEFAULT NULL,
  `Pin_Address` text DEFAULT NULL,
  `Pin_Icons` varchar(255) DEFAULT NULL,
  `Time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Pin_Owner` int(11) DEFAULT NULL,
  `PT_ID` int(11) DEFAULT NULL,
  `R_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `PinType` (
  `PT_ID` int(11) NOT NULL,
  `PT_Owner` int(11) DEFAULT NULL,
  `Editor` int(11) DEFAULT NULL,
  `R_ID` int(11) DEFAULT NULL,
  `PT_Name` varchar(100) DEFAULT NULL,
  `PT_Icons` varchar(255) DEFAULT NULL,
  `PT_Status` int(11) DEFAULT NULL,
  `Time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `Room` (
  `R_ID` int(11) NOT NULL,
  `R_Description` text DEFAULT NULL,
  `Images` varchar(255) DEFAULT NULL,
  `R_Owner` int(11) DEFAULT NULL,
  `R_Name` varchar(255) DEFAULT NULL,
  `R_Status` tinyint(1) DEFAULT NULL,
  `R_Type` tinyint(1) DEFAULT NULL,
  `Mute` tinyint(1) DEFAULT NULL,
  `Visible` tinyint(1) DEFAULT NULL,
  `R_Tell` int(10) DEFAULT NULL,
  `R_Detail` text DEFAULT NULL,
  `Province` varchar(255) DEFAULT NULL,
  `Time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `RoomID` (
  `R_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `Room_Member` (
  `RM_ID` int(11) NOT NULL,
  `R_ID` int(11) DEFAULT NULL,
  `User_Member` int(11) DEFAULT NULL,
  `R_Class` int(3) DEFAULT NULL,
  `Status` tinyint(1) DEFAULT NULL,
  `Room_BlackList` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `SocialNumber` (
  `SN_ID` int(11) NOT NULL,
  `CA_ID` int(11) DEFAULT NULL,
  `SN_name` varchar(100) DEFAULT NULL,
  `SN_Icons` varchar(255) DEFAULT NULL,
  `number` int(1) DEFAULT NULL,
  `Time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `Users` (
  `U_ID` int(11) NOT NULL,
  `U_Name` varchar(255) DEFAULT NULL,
  `U_Email` varchar(255) DEFAULT NULL,
  `U_Image` varchar(255) DEFAULT NULL,
  `U_Username` varchar(100) DEFAULT NULL,
  `U_Password` varchar(100) DEFAULT NULL,
  `U_Location` varchar(255) DEFAULT NULL,
  `U_Status` tinyint(1) DEFAULT NULL,
  `U_User_Tell` int(10) DEFAULT NULL,
  `U_Show_Tell` tinyint(1) DEFAULT NULL,
  `U_Time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `U_Class` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
