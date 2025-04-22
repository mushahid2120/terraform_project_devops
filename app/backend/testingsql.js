import React,{ useEffect, useState } from 'react'
import axios from 'axios'
import './App.css'

import Demo from "./my.jsx"

function App() {
  const [data, setData] = useState('')
  const [messages, setMessages] = useState([]);

  useEffect(()=>{
    const fetchMessages= async()=>{
      try{
          const response= await axios.get('/fetch')
          setMessages(response.data.messages || []);
          // console.log(response.data.messages)
          // response.map((each)=>{
          //   console.log(each.Respose)
          // })
      }catch (error){
        console.log(error)
      }
    };
    fetchMessages();
  },[])

const handleSubmit= async (e)=>{
e.preventDefault();
 try{
   const response= await axios.post('/submit',{data});
    // alert(response.data.message);
    setData('');
    const response2 = await axios.get('/fetch');
    setMessages(response2.data.message || []);
   } catch(error){
     console.log(error);
//     alert(error);
}
 }

  return (
    <div className="container">
      <h1 className="heading">Enter what you want to save in MongoDB Database</h1>
      <form onSubmit={handleSubmit}>
        <div>
          <input
            type="text"
            className="texting"
            value={data}
            onChange={(e) => setData(e.target.value)}
            placeholder="Enter data here"
          />
      </div>
        <div>
          <button type="submit" className="button">
            Submit
          </button>
        </div>
        <div>
          <h1 className="submitted">Submitted Messages</h1>
          <div className="submitted-messages">
              {messages.slice().reverse().map((message, index)=>(
                <p key={index}>{message.Response}</p>
              ))}
          </div>
        </div>
      </form>
    </div>
  )
  // return (<h1>Hello World!!!!!!</h1>)
}

export default App
