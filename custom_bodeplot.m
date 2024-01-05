function o = custom_bodeplot(sys,IN_label,OUT_label, title_label,fig,fileName)
    [mag, phase, wout] = bode(sys);
    mag=20*log10(mag);
    figure(fig);
    
    t = tiledlayout(8,2,"TileSpacing","tight");
    title(t, title_label)
    for i=1:4
        min_mag=floor(squeeze(min(min(mag(i,:,:))))/20)*20;
        max_mag=ceil(squeeze(max(max(mag(i,:,:))))/20)*20;
        ylim_mag = [min_mag max_mag];
        min_phase=floor(squeeze(min(min(phase(i,:,:))))/90)*90;
        max_phase=ceil(squeeze(max(max(phase(i,:,:))))/90)*90;
        ylim_phase = [min_phase max_phase];
        if max_phase-min_phase>270
            step_phase=180;
        else
            step_phase=90;
        end
        yticks_phase = min_phase:step_phase:max_phase;
        yticks_mag = linspace(min_mag, max_mag, 5);
        for j=1:2
            h_mag=nexttile((i-1)*4+j);
            semilogx(wout,squeeze(mag(i,j,:)),'LineWidth',2)
            set(h_mag,'YLim',ylim_mag,'YTick',yticks_mag)
            
            h_phase=nexttile(i*4-2+j);
            semilogx(wout,squeeze(phase(i,j,:)),'LineWidth',2)
            set(h_phase,'YLim',ylim_phase,'YTick',yticks_phase)
            if i==1
                set(get(h_mag,'Title'), 'String', strcat('Entrada: ',IN_label(j)));
            end
            if i<4
                set(h_mag,'xticklabel',[])
                set(h_phase,'xticklabel',[])
            else
                set(h_mag,'xticklabel',[])
                set(get(h_phase,'XLabel'), 'String', 'Frecuencia [rad/s]' )
            end

            if j>1
                set(h_mag,'yticklabel',[])
                set(h_phase,'yticklabel',[])
                set( get(h_phase,'YLabel'), 'String', '' );
            else
                set( get(h_phase,'YLabel'), 'String', {OUT_label{i},' Fase[deg]'},'FontWeight','bold');
                set( get(h_mag,'YLabel'), 'String', {OUT_label{i},' Mag[dB]'} ,'FontWeight','bold');
            end

        end
    end
    
    set(gcf, 'Position',  [100, 100, 1000, 800]);
    saveas(gcf,[fileName]);
end