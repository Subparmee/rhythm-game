import React, { useEffect, useRef, useState } from 'react';
import WaveSurfer from 'wavesurfer.js';
import TimelinePlugin from 'wavesurfer.js/dist/plugins/timeline.esm.js';

function MapMaker({ audioFile }) {
    const waveformRef = useRef(null);
    const wavesurferRef = useRef(null);

    const [isPlaying, setIsPlaying] = useState(false);

    useEffect(() => {
        if (!audioFile || !waveformRef.current) return;
        const objectUrl = URL.createObjectURL(audioFile);

        const ws = WaveSurfer.create({
            container: waveformRef.current,
            waveColor: '#4F4A85',
            progressColor: '#383351',
            cursorColor: '#ff4d4d',
            barWidth: 2,
            barGap: 1,
            barRadius: 2,   
            height: 128,
            normalize: true,
            minPxPerSec: 100,
            // 2. Pass timeline configuration correctly inside the plugins array
            plugins: [
                TimelinePlugin.create({
                    timeInterval: 5,
                    primaryLabelInterval: 30,
                    secondaryLabelInterval: 10,
                })
            ],
        });

        ws.load(objectUrl);
        ws.on('play', () => setIsPlaying(true));
        ws.on('pause', () => setIsPlaying(false));

        wavesurferRef.current = ws;

        return () => {
            ws.destroy();
            URL.revokeObjectURL(objectUrl);
        }

    }, [audioFile]);

    const handlePlayPause = () => {
        if (wavesurferRef.current) {
            wavesurferRef.current.playPause();
        }
    };

    return(
        <div className="mapmaker">
            <header className="mapmakerheader">
                <h1>Beat Map Maker</h1>
            </header>

            <main style={{ padding: '20px' }}>
                <h2>Now Editing: {audioFile?.name}</h2>
                <div 
                    ref={waveformRef} 
                    style={{ width: '100%', marginTop: '20px', background: '#f0f0f0', borderRadius: '8px' }} 
                />
                <div style={{ marginTop: '20px' }}>
                    <button onClick={handlePlayPause} style={{ padding: '10px 20px', fontSize: '16px' }}>
                        {isPlaying ? 'Pause' : 'Play'}
                    </button>
                </div>
                {/* 3. Removed the broken <audio> tag because Wavesurfer handles playback now */}
            </main>
        </div>
    );
}

export default MapMaker;