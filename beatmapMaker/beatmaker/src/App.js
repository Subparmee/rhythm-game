import logo from './logo.svg';
import './App.css';
import React, {useState} from 'react';
import Home from './Home';
import MapMaker from './MapMaker';

function App() {
  const [currentView, setCurrentView] = useState('home');
  const [audioFile, setAudioFile] = useState(null);

  const handleStartProject = () => {
    setAudioFile(file);
    setCurrentView('mapmaker');
  };

  return (
    <div>
      {currentView === 'home' ? (
        <Home onStart={handleStartProject} />
      ) : (
        <MapMaker audioFile={audioFile}/>
      )}
    </div>
  );

  return (
    <div><Home /></div>
  );
}

export default App;
