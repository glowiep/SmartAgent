import { MdDashboard, MdEmail, MdOutlineChatBubble } from "react-icons/md";

export const menuItems = [
  { icon: <MdDashboard className="w-[30px] h-[30px] "/>, tooltip: 'Dashboard', path: '/dashboard' },
  { icon: <MdEmail className="w-[30px] h-[30px] "/>, tooltip: 'Emails', path: '/main' },
  { icon: <MdOutlineChatBubble className="w-[30px] h-[30px] "/>, tooltip: 'Chat', path: '/chat' },
 
];