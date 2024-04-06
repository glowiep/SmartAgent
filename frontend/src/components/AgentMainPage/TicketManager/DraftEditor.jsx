
import { useState } from 'react';

// Packages required for HTML text editor
import ReactQuill from 'react-quill'
import 'quill/dist/quill.snow.css'
import DOMPurify from 'dompurify';

// Import constants
import { modules, formats } from '../../../constants/draft-editor-format';

function DraftEditor({ customer_name }) {
  const [editorState, setEditorState] = useState();

  const handleProcedureContentChange = (content) => {
    console.log("content---->", content);
    const sanitizedContent = DOMPurify.sanitize(content)
    setEditorState(sanitizedContent); // Update editorState with the content
  };

  const defaultValue = `<p>Hi ${customer_name}, </p><p><br></p><p><br></p><p>Regards,</p><p><br></p><p><strong>SmartAgent</strong></p><p>Customer Support</p><p>smartagents3@gmail.com</p>`

  return (
    <div>
      <div className="pb-10">
        <ReactQuill
          theme="snow"
          modules={modules}
          formats={formats}
          placeholder="..."
          defaultValue={defaultValue}
          onChange={handleProcedureContentChange}
          style={{ height: "17em", width: "100%"}}
        >
        </ReactQuill>
      </div>
      
      {/* Delete the below after testing is completed */}
      <h2>Editor Content:</h2>
      <p>{editorState}</p> {/* Display the editor content */}
    </div>
  );
}

export default DraftEditor;