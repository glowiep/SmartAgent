import { MdDashboard,MdEmail, MdOutlineChatBubble, MdLocalPhone,MdContacts,MdOutlineSettings    } from "react-icons/md";


export const menuItems = [
  { icon: <MdDashboard className="w-[30px] h-[30px] "/>, tooltip: 'Dashboard', path: '/dashboard' },
  { icon: <MdEmail className="w-[30px] h-[30px] "/>, tooltip: 'Emails', path: '/main' },
  { icon: <MdOutlineChatBubble className="w-[30px] h-[30px] "/>, tooltip: 'AI Chatbot', path: '/chat' },
  { icon: <MdContacts className="w-[30px] h-[30px] "/>, tooltip: 'Agents', path: '/agents' },
  { icon: <MdOutlineSettings className="w-[30px] h-[30px] "/>, tooltip: 'Profile', path: '/profile' },
];