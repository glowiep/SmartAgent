// State management is centralized here
import { createContext, useReducer, useContext } from "react";

export const ACTIONS = {
  SET_VIEW: "SET_VIEW",
  VIEW_TICKET: "VIEW_TICKET",
  COUNT_TRIAGE: "COUNT_TRIAGE",
  COUNT_ALL: "COUNT_ALL",
  COUNT_CLOSED: "COUNT_CLOSED",
  COUNT_ASSIGNED_TO_ME: "COUNT_ASSIGNED_TO_ME",
  GET_TICKET_DATA: "GET_TICKET_DATA",
  GET_AGENTS: "GET_AGENTS",
  GET_INBOX_TICKETS: "GET_INBOX_TICKETS",
  ADD_INBOX_TICKET: "ADD_INBOX_TICKET",
  UPDATE_INBOX_TICKET: "UPDATE_INBOX_TICKET",
  DELETE_INBOX_TICKET: "DELETE_INBOX_TICKET",
  ADD_CONVERSATION: "ADD_CONVERSATION",
  SET_AGENT: "SET_AGENT"
};

function reducer(state, action) {
  switch (action.type) {
    case ACTIONS.SET_VIEW:
      return {
        ...state,
        ticketManagerView: action.payload,
        ticketInboxView: true,
        ticketInfoView: false,
      };
    case ACTIONS.VIEW_TICKET:
      return {
        ...state,
        viewTicketId: action.payload,
        ticketInboxView: false,
        ticketInfoView: true,
      };
    case ACTIONS.ADD_CONVERSATION:
      return {
        ...state,
        ticketData:
          state.ticketData.id === action.payload.ticket_id
            ? {
                ...state.ticketData,
                conversations: [
                  ...state.ticketData.conversations,
                  action.payload,
                ],
              }
            : state.ticketData,
      };
    case ACTIONS.COUNT_ALL:
      return { ...state, countAll: action.payload };
    case ACTIONS.COUNT_TRIAGE:
      return { ...state, countTriage: action.payload };
    case ACTIONS.COUNT_CLOSED:
      return { ...state, countClosed: action.payload };
    case ACTIONS.COUNT_ASSIGNED_TO_ME:
      return { ...state, countAssignedToMe: action.payload };
    case ACTIONS.GET_TICKET_DATA:
      return { ...state, ticketData: action.payload, ticketUpdated: false };
    case ACTIONS.GET_AGENTS:
      return { ...state, agents: action.payload };
    case ACTIONS.GET_INBOX_TICKETS:
      return { ...state, inboxTickets: action.payload, ticketUpdated: false };
    case ACTIONS.ADD_INBOX_TICKET:
      return {
        ...state,
        inboxTickets: [action.payload, ...state.inboxTickets],
        ticketUpdated: true,
      };
    case ACTIONS.UPDATE_INBOX_TICKET:
      return {
        ...state,
        inboxTickets: state.inboxTickets.map((ticket) =>
          ticket.id === action.payload.id ? action.payload : ticket
        ),
        ticketUpdated: true,
      };
    case ACTIONS.DELETE_INBOX_TICKET:
      return {
        ...state,
        inboxTickets: state.inboxTickets.filter(
          (ticket) => ticket.id !== action.payload
        ),
        ticketUpdated: true,
      };
    case ACTIONS.SET_AGENT:
      return {
        ...state,
        loggedInAgent: { agent_id: action.payload.agent_id, full_name: action.payload.full_name}
      };
    default:
      throw new Error(
        `Tried to reduce with unsupported action type: ${action.type}`
      );
  }
}

const INITIAL_STATE = {
  ticketManagerView: "Triage - Open Tickets",
  countAssignedToMe: 0,
  countTriage: 0,
  countAll: 0,
  countClosed: 0,
  viewTicketId: "",
  ticketInboxView: true,
  ticketInfoView: false,
  ticketData: [],
  agents: [],
  inboxTickets: [],
  ticketUpdated: false,
  loggedInAgent: {}
};

export const AppContext = createContext();

export const AppProvider = ({ children }) => {
  const [state, dispatch] = useReducer(reducer, INITIAL_STATE);

  return (
    <AppContext.Provider value={{ state, dispatch }}>
      {children}
    </AppContext.Provider>
  );
};

export const useAppContext = () => {
  return useContext(AppContext);
};
