import axios from "axios";
import { useEffect, useState } from "react";
import { FaNotesMedical } from "react-icons/fa6";
import { MdCancel } from "react-icons/md";
import { BiSend } from "react-icons/bi";
import ActionCable from "actioncable";

function NotesSidePanel({ ticket_id, setNotesPanel }) {
  const [notes, setNotes] = useState([]);
  const [isCreatingNote, setIsCreatingNote] = useState(false);
  const [newNoteBody, setNewNoteBody] = useState("");

  useEffect(() => {
    const cable = ActionCable.createConsumer("ws://localhost:3000/cable");
    const subscription = cable.subscriptions.create("NotesChannel", {
      received: (data) => {
        setNotes([data, ...notes]);
      },
    });
    return () => {
      cable.subscriptions.remove(subscription);
    };
  }, [notes]);
  useEffect(() => {
    axios.get("api/v1/notes").then((response) => {
      const filterNotes = response.data.filter(
        (note) => note.ticket_id === ticket_id
      );
      setNotes(filterNotes);
    });
  }, [ticket_id]);

  const createNote = (value) => {
    axios
      .post("api/v1/notes", { ticket_id: ticket_id, body: value })
      .then((response) => {
        // const newNote = response.data;
        // setnotes([...notes, newNote]);
        console.log(response.data);
      });
  };
  return (
    <div className="bg-gray-200 dark:bg-gray-400 text-black border-r-4 border-double absolute z-10 h-[90%] lg:w-[25%] w-[40%] right-0 rounded-2xl shadow-2xl overflow-y-scroll">
      <div className="flex flex-col justify-between mt-5 p-3 pb-0">
        <a className="btn btn-ghost lg:text-3xl text-xl font-bold mb-4">
          <img src="/SmartAgent-icon.svg" alt="SmartAgent icon" width="45" />
          Ticket Notes
        </a>
        <div className="flex flex-row justify-center items-center gap-4">
          <button
            className="btn dark:btn-primary text-sm font-bold mb-2"
            onClick={() => setIsCreatingNote(prev => !prev)}
          >
            <FaNotesMedical size="1.5rem" />
            New Note
          </button>
          <button
            className="btn btn-neutral text-white text-sm font-bold mb-2"
            onClick={() => setNotesPanel((prev) => !prev)}
          >
            <MdCancel size="1.5rem" />
            Close
          </button>
        </div>
      </div>

      <div className="p-3">
        {isCreatingNote && (
          <div className="ring-yellow-600/20 ml-2 mr-2 mb-1 pt-1 pb-1 pl-2 pr-4 flex flex-col items-start">
            <textarea              
              value={newNoteBody}
              onChange={(e) => setNewNoteBody(e.target.value)}
              className="inline-flex items-center mr-2 mb-2 rounded-sm bg-yellow-50 px-2 py-1 w-full font-medium text-yellow-800 ring-1 ring-inset ring-yellow-600/20"
            />
            <button
              className="btn btn-primary text-white dark:text-black font-bold"
              onClick={() => {
                createNote(newNoteBody);
                setNewNoteBody("");
                setIsCreatingNote(false);
              }}
            >
              <BiSend size="1.5rem" />
              Add Note
            </button>
          </div>
        )}
        {notes.map((note) => {
          const date = new Date(note.updated_at);
          const formattedDate = `${date.getDate()}/${date.getMonth() + 1}/${date.getFullYear()} ${date.getHours()}:${date.getMinutes()}`;
          return (
            <ul key={note.id}>
              <li className="ring-yellow-600/20 ml-2 mr-2 mb-1 pt-1 pb-1 pl-2 pr-2">
                <p className="text-slate-400 dark:text-gray-700">{formattedDate}</p>
                <span className="inline-flex items-center mr-2 rounded-sm bg-yellow-50 px-2 py-1 font-medium text-yellow-800 ring-1 ring-inset ring-yellow-600/20 whitespace-pre-wrap">
                  {note.body}
                </span>
              </li>
            </ul>
          );
        })}
      </div>
    </div>
  );
}

export default NotesSidePanel;
