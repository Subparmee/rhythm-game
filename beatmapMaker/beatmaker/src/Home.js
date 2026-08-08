import React, {useState} from 'react';


function Home(){
    const [activePopup, setActivePopup] = useState(null);
    const [selectedFile, setSelectedFile] = useState(null);

    const closePopup = () => {
        setActivePopup(null);
        setSelectedFile(null);
    };

    const handleFileChange = (e) => {
        if (e.target.files && e.target.files.length > 0) {
            setSelectedFile(e.target.files[0]);
        }
    };

    const handleCreate = () => {
        if (!selectedFile) {
            alert("Please select an audio file first!");
            return;
        }
        // Pass the file up to App.js
        onStart(selectedFile); 
    };

    return(
        <div className = "home">
            <header className = "homeheader">
                <h1>Beat Map Maker</h1>
            </header>
            <main className = "homebody">
                <h2>Select Map</h2>
            </main>
            <section className = "buttons">
                <button type = "button" onClick= {() => setActivePopup('create')}>Create New Project</button>
                <button type = "button" onClick= {() => setActivePopup('import')}>Import Existing Project</button>
            </section>

            {activePopup === 'create' && (
                <div className = "popupoverlay">
                    <div className = "popupcontent">
                        <h2>Create New Project</h2>
                        <p>Upload your audio file to get started</p>
                        <input type = "file" accept = "audio/*" onChange={handleFileChange}/>
                        <br /><br />
                        <button type = "button" onClick = {handleCreate}>Create</button>
                        <button type = "button" onClick = {closePopup}>Cancel</button>
                    </div>
                </div>
            )}
            {activePopup === 'import' && (
                <div className = "popupoverlay">
                    <div className = "popupcontent">
                        <h2>Import Existing Project</h2>
                        <p>Upload your existing map file</p>
                        <input type = "file" accept = ".json"/>
                        <br /><br />
                        <button type = "button" onClick = {onStart}>Import</button>
                        <button type = "button" onClick = {closePopup}>Cancel</button>
                    </div>
                </div>
            )}
        </div>
    );
}

export default Home;