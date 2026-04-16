import React, {useState} from 'react';


function Home(){
    const [activePopup, setActivePopup] = useState(null);
    const closePopup = () => {
        setActivePopup(null);
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
                        <input type = "file" accept = "audio/*"/>
                        <br /><br />
                        <button type = "button">Create</button>
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
                        <button type = "button">Import</button>
                        <button type = "button" onClick = {closePopup}>Cancel</button>
                    </div>
                </div>
            )}
        </div>
    );
}

export default Home;