# SmartAgent 💬
SmartAgent is a customer support ticket management application, paired with an AI assistant.

<!-- ## Goals 🏆 -->

<!-- ## Features ✅ -->


## Getting Started ✨
To run this project locally, clone this repository and navigate to the root directory.

### Requirements
- Ruby version 3.3.0
- NodeJS >= 18.15.0

### Back-end 🚅
1. Navigate to the /backend folder.

2. Run ```bundle install``` to install dependencies.

3. Create config/database.yml by copying config/database.example.yml. Set up the database credentials in this file.

4. Run migrations with ```bin/rails db:migrate```.

4. If you want to recreate the database from scratch, run ```bin/rails db:reset``` to create, load and seed the datbase. Check step 3 if this returns an error.

5. Run ```bin/rails s -b 0.0.0.0``` to start the server

### Frontend 🚀
1. Navigate to the /frontend folder.

2. Install dependencies by running ```npm install```.

3. Run ```npm run dev``` to start the frontend server. It will run on http://localhost:5173


<details>
  <summary>Backend Dependencies 🪄</summary>

  ### Ruby Version
  - **ruby** (3.3.0): Ruby programming language version used in the backend.

  ### Ruby Gems
  - **rails** (~> 7.1.3, >= 7.1.3.2): Ruby on Rails framework for building web applications.
  - **pg** (~> 1.1): PostgreSQL adapter for Active Record, used as the database.
  - **puma** (>= 5.0): Web server used for serving the Rails application.
  - **jbuilder**: Gem for building JSON APIs in Rails.
  - **email_reply_parser**: Gem for parsing email replies in Rails applications.
  - **bcrypt** (~> 3.1.7): Ruby gem for password hashing and authentication.
  - **devise** (~> 4.9, >= 4.9.3): Flexible authentication solution for Rails applications.
  - **tzinfo-data**: Gem providing timezone data for Rails applications.
  - **bootsnap**: Gem for reducing boot times through caching.
  - **rubocop**: Ruby code style checker and formatter.
  - **ruby-lsp**: Ruby Language Server Protocol implementation.
  - **rack-cors**: Gem for handling Cross-Origin Resource Sharing (CORS) in Rack-based applications.

  <details>
    <summary>📌 Backend Development and Test Dependencies</summary>
    
    - **debug**: Gem for debugging Rails applications (platforms: MRI, Windows).
    - **faker**: Gem for generating fake data for testing.
    - **rspec-rails**: Testing framework for Rails applications.
  </details>
</details>

<details>
  <summary>Frontend Dependencies 🪄</summary>

  - **@react-oauth/google** (^0.12.1): Used for Google OAuth authentication in React applications.
  - **axios** (^1.6.8): A promise-based HTTP client for making API requests.
  - **dompurify** (^3.0.11): Helps prevent XSS (Cross-Site Scripting) attacks by sanitizing HTML content.
  - **formik** (^2.4.5): Formik is used for building forms in React and handling form state.
  - **localforage** (^1.10.0): Provides a simple localStorage-like API for storing data asynchronously.
  - **match-sorter** (^6.3.4): Utility for sorting and filtering arrays based on user input.
  - **react** (^18.2.0) and **react-dom** (^18.2.0): Core React libraries for building user interfaces.
  - **react-icons** (^5.0.1): Library containing a collection of popular icons for React applications.
  - **react-quill** (^2.0.0): Rich text editor component for React applications.
  - **react-router-dom** (^6.22.3): React bindings for the React Router library, used for routing in React applications.
  - **sort-by** (^1.2.0): Utility function for sorting arrays of objects by specific keys.
  - **yup** (^1.4.0): A JavaScript schema builder for validation, used with Formik for form validation.

  <details>
    <summary>📌 Frontend Development and Test Dependencies</summary>

    #### TypeScript Types
    - **@types/react** (^18.2.66): TypeScript types for React.
    - **@types/react-dom** (^18.2.22): TypeScript types for ReactDOM.

    #### Vite and React Plugins
    - **@vitejs/plugin-react** (^4.2.1): Vite plugin for React support.

    #### CSS and Styling
    - **autoprefixer** (^10.4.19): PostCSS plugin to parse CSS and add vendor prefixes.
    - **daisyui** (^4.8.0): Tailwind CSS components and utilities.
    - **postcss** (^8.4.38): Tool for transforming CSS with JavaScript plugins.
    - **tailwindcss** (^3.4.1): Utility-first CSS framework for styling.

    #### Linting and Code Quality
    - **eslint** (^8.57.0): JavaScript and TypeScript linter.
    - **eslint-plugin-react** (^7.34.1): ESLint plugin for React.
    - **eslint-plugin-react-hooks** (^4.6.0): ESLint plugin for React hooks.
    - **eslint-plugin-react-refresh** (^0.4.6): ESLint plugin for React Refresh.

    #### Build Tools
    - **vite** (^5.2.0): Build tool for modern web development with fast build times.
  </details>
</details>