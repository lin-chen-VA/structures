function rotamerPlot(fileName, bin, cutoff)
    %fileName, file name of raw data
    %bin, interval of angles
    %cutoff
    l = csvread(fileName, 0, 4);
    l = l(:, 3:5); % use phi, psi, and chi_1
    figure;
    phipsi = l(:, 1:2);
    %hist3(phipsi);
    %ndhist(phipsi);
    ndhist(phipsi, 'axis', [0 360 0 360], '3d', 'columns');
    %xlabel('Phi');
    %ylabel('Psi');
    %set(gca,'fontsize',20)
    xlabel('Phi', 'FontWeight','bold')
    ylabel('Psi', 'FontWeight','bold')
    phichi = [l(:, 1), l(:, 3)];
    figure;
    %ndhist(phichi);
    ndhist(phichi, 'axis', [0 360 0 360]);
%     xlabel('Phi');
%     ylabel('Chi_1');
    set(gca,'fontsize',20)
    xlabel('Phi', 'FontWeight','bold')
    ylabel('Chi_1', 'FontWeight','bold')
    psichi = l(:, 2:3);
    figure;
    ndhist(psichi);
%     xlabel('Psi');
%     ylabel('Chi_1');
    set(gca,'fontsize',20)
    xlabel('Psi', 'FontWeight','bold')
    ylabel('Chi_1', 'FontWeight','bold')
    binNum = 360/bin+1;
    bins = linspace(0, 360, binNum);
    bins = bins(2:end);
    index = 1;
    figure;
    for i = bins
        for j = bins
            t = l( (l(:, 1) >= i-bin) & (l(:, 1) < i) & (l(:, 2) >= j-bin) & (l(:, 2) < j), :); 
            chi_1 = t(:, 3); % get the column representing chi_1
            ax = subplot(size(bins, 2), size(bins, 2), index);
            index = index + 1;
            %histogram(chi_1);
            %figure
            [bincounts] = histc(chi_1, 0:10:360);
%             if max(bincounts) < cutoff
%                 uplimit = cutoff;
%             else
%                 uplimit = max(bincounts);
%             end
%             if uplimit > 2*cutoff
%                 bar(0:10:360, bincounts, 'r');
%             else
%                 bar(0:10:360, bincounts, 'histc');
%             end
            bar(0:10:360, bincounts);
            axis(ax, [0 360 0 cutoff]);
            set(ax, 'XTick', [], 'XTickLabel', []);
            xlabel(ax, strcat('(', int2str(i), ',', int2str(j), ')'));
        end
    end
    figure;
    plot3k(l, 'Labels', {'Rotamer Density', 'Phi', 'Psi', 'Chi_1'});
     set(gca,'fontsize',20)
    xlabel('Phi', 'FontWeight','bold')
    ylabel('Psi', 'FontWeight','bold')
    zlabel('Chi_1', 'FontWeight','bold')
end