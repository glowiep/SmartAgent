import { sidePanelItems } from "../../../constants/side-panel-items"
import useApplicationData from "../../../hooks/useApplicationData";
import { useAppContext } from "../../../context/TicketManagerContext";

function TicketSidePanel() {
  const { state } = useAppContext();
  const { setTicketManagerView } = useApplicationData();
  return (
    <div className="bg-base-200 border-r-4 border-double w-1/5">
      <h1 className="text-2xl font-bold mb-4 ml-4">Tickets</h1>
      
      <div>
        <ul>
          {sidePanelItems.map((item, index) => (
            <li 
              key={index} 
              className="ring-yellow-600/20 ml-2 mr-2 mb-1 pt-1 pb-1 pl-2 pr-2 hover:bg-slate-200 rounded cursor-pointer"
              onClick={() => setTicketManagerView(item.title)}
            >
              <span className="inline-flex items-center mr-2 rounded-full bg-yellow-50 px-2 py-1 text-xs font-medium text-yellow-800 ring-1 ring-inset ring-yellow-600/20">
                {state[item.count]}
              </span>
              <label className="cursor-pointer" htmlFor="status">{item.title}</label>
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
}

export default TicketSidePanel;
