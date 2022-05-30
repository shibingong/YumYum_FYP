import React, { useState } from 'react';
import PropTypes from 'prop-types';
import axios from 'axios';
import { setUserSession, getToken } from '../utils/Common';

function Login({ setToken }) {
  const [loading, setLoading] = useState(false);
  const username = useFormInput('');
  const password = useFormInput('');
  const [error, setError] = useState(null);

  // handle button click of login form
  const handleLogin = () => {
    setError(null);
    setLoading(true);
    axios.post('http://localhost:3000/login/admin', { username: username.value, password: password.value }).then(response => {
      setLoading(false);
      console.log(response.data);
      setToken(response.data);
      setUserSession(response.data.token);
    }).catch(error => {
      setLoading(false);
      if (error.response?.status === 401) setError(error.response.data.message);
      else setError("Something went wrong. Please try again later.");
    });
  }

  return (
    // <div>
    //   Login<br /><br />
    //   <div>
    //     Username<br />
    //     <input type="text" {...username} autoComplete="new-password" />
    //   </div>
    //   <div style={{ marginTop: 10 }}>
    //     Password<br />
    //     <input type="password" {...password} autoComplete="new-password" />
    //   </div>
    //   {error && <><small style={{ color: 'red' }}>{error}</small><br /></>}<br />
    //   <input type="button" value={loading ? 'Loading...' : 'Login'} onClick={handleLogin} disabled={loading} /><br />
    // </div>
    <section className="h-100 gradient-form">
      <div className="container py-5 h-100">
        <div className="row d-flex justify-content-center align-items-center h-100 ">
          <div className="col-lg-6 border">
            <div className="card-body p-md-5 mx-md-4">

              <div className="text-center">
                <h4 className="mt-1 mb-5 pb-1">YumYum Admin Page</h4>
              </div>

              <form>
                <p>Please login to your account</p>

                <div className="form-outline mb-4">
                  <input type="text" className="form-control"
                    placeholder="username" {...username} autoComplete="new-password" />
                </div>

                <div className="form-outline mb-4">
                  <input type="password" className="form-control" placeholder='password'  {...password} autoComplete="new-password" />
                </div>
                {error && <><small style={{ color: 'red' }}>{error}</small><br /></>}<br />

                <div className="text-center pt-1 mb-5 pb-1">
                  <input type="button" className="btn btn-primary btn-block fa-lg gradient-custom-2 mb-3" value={loading ? 'Loading...' : 'Log in'} onClick={handleLogin} disabled={loading} />
                </div>

              </form>

            </div>
          </div>
        </div>
      </div>
    </section>
  );
}

const useFormInput = initialValue => {
  const [value, setValue] = useState(initialValue);

  const handleChange = e => {
    setValue(e.target.value);
  }
  return {
    value,
    onChange: handleChange
  }
}

Login.propTypes = {
  setToken: PropTypes.func.isRequired
}

export default Login;