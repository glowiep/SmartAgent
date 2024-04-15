// Packages required for HTML text editor
import ReactQuill from 'react-quill'
import 'quill/dist/quill.snow.css'
import DOMPurify from 'dompurify';

// HTML to Markdown converter
import turndown from "turndown";

// Component to render markdown - remove after testing is done
import Markdown from "react-markdown"
import { useState } from 'react';

// Import constants
import { modules, formats } from '../../../constants/draft-editor-format';

function DraftEditor({ customer_name, editorState, setEditorState }) {
  // Delete after testing
  const [htmlState, setHtml] = useState("");

  const turndownService = new turndown({ option: 'hr' });
  turndownService.keep(['hr'])
  
  const handleProcedureContentChange = (content) => {
    console.log("content---->", content);
    const sanitizedContent = DOMPurify.sanitize(content)
    setHtml(sanitizedContent)  // Delete after testing
    // Update editorState with the content that is converted to markdown
    setEditorState(turndownService.turndown(sanitizedContent));    
  };

  const defaultValue = `<p>Hi ${customer_name}, </p><p><br></p><br><p><br></p><p>Regards,</p><p><br></p><p><strong>SmartAgent</strong></p><p>Customer Support</p><a href="mailto:smartagents3@gmail.com">smartagents3@gmail.com</a>`

  return (
    <div>
      <div className="pb-10 dark:text-white">
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
    </div>
  );
};

export default DraftEditor;