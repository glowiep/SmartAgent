import { Link } from "react-router-dom";
import RequestForm from "./RequestForm";
import Footer from "../Footer/Footer";

function Hero() {
  return (
    <div className="flex-col">
      <div
        className="hero min-h-screen"
        style={{
          backgroundImage:
            "url(https://images.unsplash.com/photo-1711356042156-da2e7ae500eb?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D)",
        }}
      >
        <div className="hero-overlay bg-opacity-60"></div>
        <div className="hero-content text-center text-neutral-content">
          <div className="max-w-md">
            <h1 className="mb-5 text-7xl font-bold text-slate-200">Welcome to SmartAgent</h1>
            <div className="flex items-center justify-center">
              <img src="/SmartAgent-icon.svg" alt="SmartAgent icon" width="140" />
            </div>
            <p className="mb-5 text-4xl font-bold text-slate-300">
              Are you a
            </p>
            <div className="flex items-center justify-center gap-5">
              <a href="#customer-request-form" className="btn btn-primary w-[40%]">
              Customer
              </a>
              <Link to="/login" className="btn btn-primary w-[40%]">
              SmartAgent
              </Link>
            </div>
          </div>
        </div>
      </div>
        
      <div id="customer-request-form">
        <RequestForm />
      </div>

      <Footer />
    </div>
  );
}

export default Hero;
