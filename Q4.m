clear;clc;
%%
load('x.mat');
load('A.mat');
load('MST.mat');
load('MSTsparse.mat');

%% Create AVI object
vidObj1 = VideoWriter('Q4E.avi');
vidObj1.Quality = 100;
vidObj1.FrameRate = 10;
open(vidObj1);

vidObj2 = VideoWriter('Q4G.avi');
vidObj2.Quality = 100;
vidObj2.FrameRate = 10;
open(vidObj2);
%% MST of Cities
figure(1)
hold on
plot(x(:,1), x(:,2),'ko');
axis([-0.05 1 0 1]);

[i,j] = find(Tree);
for n=1:1:length(i)
    plot([x(i(n,1), 1) x(j(n,1), 1)], [x(i(n,1), 2) x(j(n,1), 2)],'g-');
end


%% Eulerian Walk & TSP Tour
G = MST;
[i,j] = find(Tree > 0);
for n = 1 : 1 :length(i) % double the edges of every nodes
    G(i(n),j(n)) = 2;
	G(j(n),i(n)) = 2;
end

figure(2)
hold on
[i,j] = find(G == 2);
index = [j i];
plot(index(:,2),index(:,1), 'g*')
axis([0 55 0 55]);

u = randi([1 length(G(:,1))]);
start = u;
W = []; % Eulerian Walk
T = []; % TSP Tour

figure(1)
[W T] = fleury(x, G, u, start, W, T, vidObj1, vidObj2);

close(vidObj1);
close(vidObj2);