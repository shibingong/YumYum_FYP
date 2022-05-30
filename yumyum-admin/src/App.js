import React, { useState, useEffect } from 'react';
import { BrowserRouter, Routes, Route, NavLink, Link } from 'react-router-dom';
import axios from 'axios';

import Login from './Login/Login';
import Dashboard from './Dashboard/Dashboard';

import useToken from './utils/useToken';
import User from './User/User';
import Recipes from './Recipe/Recipes';

function App() {
  const { token, setToken } = useToken();

  if (!token) {
    return <Login setToken={setToken} />
  }

  const handleLogout = () => {
    // props.history.push('/login');
    localStorage.clear();
    window.location.href = '/';
  }

  return (
    <div>
      <BrowserRouter>
        {/* <div className="header">
            <NavLink className={(navData) => navData.isActive ? "active" : ""} to="/">Home</NavLink>
            <NavLink className={(navData) => navData.isActive ? "active" : ""} to="/login">Login</NavLink><small>(Access without token only)</small>
            <NavLink className={(navData) => navData.isActive ? "active" : ""} to="/dashboard">Dashboard</NavLink><small>(Access with token only)</small>
          </div> */}
        <nav className="navbar navbar-expand-lg navbar-dark bg-dark">
          <span class="navbar-brand mb-0 h1 ps-3">YumYum</span>
          <ul className="navbar-nav mr-auto">
            <li className="nav-item">
              <Link to={"/"} className="nav-link">
                Users
              </Link>
            </li>
            {/* <form className="d-flex">
              <button className="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
            </form> */}
            <li class="nav-item ps-3">
            <button className="btn btn-outline-danger my-2 my-sm-0" type="button" onClick={handleLogout}>Log Out</button>
      </li>
          </ul>
        </nav>
        <div className="container mt-3">

          <Routes>
            {/* <Route path="/login" element={< Login />} /> */}
            <Route path="/" element={< Dashboard />} />
            <Route path="/user/:id" element={< User />} />
            <Route path="/recipes/:id" element={< Recipes />} />
          </Routes>
        </div>
      </BrowserRouter>
    </div>
  );
}

export default App;